//
//  FirstViewController.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (nonatomic, strong) UINib *cellNib;
@end

//const NSString *URL = @"ontheparty.rtoledo.inf.br";
const NSString *URL = @"192.168.2.102:3000";

@implementation FirstViewController

@synthesize mapView;
@synthesize _tableView;
@synthesize locationManager;
@synthesize segmentedControl;
@synthesize cellNib = _cellNib;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    [mapView setDelegate:self];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 216, 0);
//    [tableView setDelegate:self];
    [_tableView setHidden:YES];
    [mapView setHidden:NO];
    self.cellNib = [UINib nibWithNibName:NSStringFromClass(VenueCell.class) bundle:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

//-(void)viewWillAppear:(BOOL)animated {
//    AppDelegate *delegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
//    if (!delegate.session.isOpen) {
//        //        self.facebookLoginViewController = [[FacebookLoginViewController alloc] initWithNibName:@"FacebookLoginViewController" bundle:nil];
//        //        self.window.rootViewController = self.facebookLoginViewController;
//        //        [self.window makeKeyAndVisible];
//        UIStoryboard *mainStoryBoard = self.storyboard;
//        FacebookLoginViewController *facebookLoginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FacebookLoginViewController"];
//        [self presentViewController:facebookLoginViewController animated:YES completion:nil];
//    }
//}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    [locationManager stopUpdatingLocation];
    // Release any retained subviews of the main view.
}

-(NSArray*)getAllowedCategories {
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"categories.plist"];
    NSDictionary *plistCategories = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    NSArray *categories = (NSArray*) [plistCategories objectForKey:@"ids"];
    return categories;
    
}

-(void)setVenues:(NSArray*)_venues {
    
    
    venues = [[NSMutableArray alloc] init];
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSDictionary *venueDict in _venues) {
        NSMutableArray *categories = [[NSMutableArray alloc] init];
        for (NSDictionary *categoryDict in (NSArray*) [venueDict valueForKey:@"categories"]) {
            NSDictionary *iconDict = [categoryDict valueForKey:@"icon"];
            Category *category = [[Category alloc] initWithIdFoursquare:[categoryDict valueForKey:@"id"] name:[categoryDict valueForKey:@"name"] pluralName:[categoryDict valueForKey:@"pluralName"] shortName:[categoryDict valueForKey:@"shortName"] iconPrefix:[iconDict valueForKey:@"prefix"] iconName:[iconDict valueForKey:@"name"]];
            [categories addObject:category];
        }
        NSDictionary *locationDict = [venueDict valueForKey:@"location"];
        Venue *venue = nil;
        if ([categories count] > 0 && [[self getAllowedCategories] containsObject:((Category*)[categories objectAtIndex:0]).idFoursquare]) {
            venue = [[Venue alloc] initWithIdFoursquare:[venueDict valueForKey:@"id"] 
                                                   name:[venueDict valueForKey:@"name"] 
                                                contact:[venueDict valueForKey:@"contact"] 
                                                address:[locationDict valueForKey:@"address"]
                                               latitude:[locationDict valueForKey:@"lat"] 
                                              longitude:[locationDict valueForKey:@"lng"] distance:[[locationDict valueForKey:@"distance"] doubleValue]/1000  
                                                country:[venueDict valueForKey:@"country"] 
                                             categories:categories];
            [venues addObject:venue];
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [venue.latitude doubleValue];
            coordinate.longitude = [venue.longitude doubleValue];
            VenuesAnnotation *vAnnotation = [[VenuesAnnotation alloc] initWithCoordinates:coordinate placeName:venue.name description:  venue.address];
            vAnnotation.tag = i;
            
            [annotations addObject:vAnnotation];
            i++;
        }
        
        
        
    }
    
    MKCoordinateRegion region;
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.latitudeDelta = 0.01f;
    region.span.longitudeDelta = 0.01f;
    
    [mapView setRegion:region animated:TRUE];
	
    [mapView addAnnotations:annotations];

    [locationManager stopUpdatingLocation];
    [_tableView reloadData];
}

-(void)chooseButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    Venue *venue = [venues objectAtIndex:button.tag];
    [self findOrCreateVenues:venue];
    NSLog(@"%@",venue.name);
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTag:((VenuesAnnotation*) annotation).tag];
    [rightButton addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = rightButton;
    return annotationView;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocation *currentLocation = [self.locationManager location];
    NSString *oAuthToken = @"WRRHUY3ZNHMI53KPICFLXWPWAU2EWUKPOTTADE2DEYETZHRR";
    NSString *v = @"20120529";
    NSString *latitude = [NSString stringWithFormat:@"%.2f",currentLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.2f",currentLocation.coordinate.longitude];
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@%@%@%@%@%@%@",latitude,@",",longitude,@"&oauth_token=",oAuthToken,@"&v=",v];
    
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *responseDict = [JSON valueForKeyPath:@"response"];

        [self setVenues: (NSArray*) [responseDict valueForKey:@"venues"]];
    } failure:nil];
    [operation start];
    
}

-(void)checkin:(Venue *)venue {
    
    UIStoryboard *mainStoryBoard = self.storyboard;
    VenueCheckinViewController *venueCheckinViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"CheckinController"];
    [venueCheckinViewController setVenue:venue];
    [self presentViewController:venueCheckinViewController animated:YES completion:nil];
    
//    AppDelegate *delegate = (AppDelegate*) [[UIApplication sharedApplication] delegate]; 
//    [delegate.
    
//    VenueCheckinViewController *venueCheckinViewController = [[VenueCheckinViewController alloc] initWithNibName:@"VenueCheckinViewController" bundle:nil venue:venue];
//    [mainStoryBoard instantiateViewControllerWithIdentifier:@"CheckinController"];
//    [delegate.navigationController pushViewController:venueCheckinViewController animated:YES];   
}

-(void)findOrCreateVenues:(Venue*)venue {
    NSString *urlString = [NSString stringWithFormat:@"http://%@",URL];
    NSURL *url = [NSURL URLWithString: [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary* venueDict = [NSDictionary dictionaryWithObjectsAndKeys:venue.idFoursquare,@"id_foursquare", 
                               [NSString stringWithFormat:@"%@", venue.latitude], @"latitude",
                               [NSString stringWithFormat:@"%@",venue.longitude],@"longitude",  
                               venue.name,@"name",  nil];
    
    Category* category = [venue.categories objectAtIndex:0];
    
    NSDictionary* categoryDict = [NSDictionary dictionaryWithObjectsAndKeys:category.idFoursquare,@"id_foursquare",  
                                  category.iconName, @"icon_name", 
                                  category.iconPrefix,@"icon_prefix",  
                                  @"name", category.name, nil];
    NSDictionary* parametersDict = [NSDictionary dictionaryWithObjectsAndKeys:venueDict,@"venue",  categoryDict,@"category",  nil];
    NSDictionary* foursquareParams = [NSDictionary dictionaryWithObjectsAndKeys:parametersDict,@"foursquare_params", nil];     
    NSURLRequest *request = [httpClient  requestWithMethod:@"POST" path:@"/api/venues/find_or_create" parameters:foursquareParams];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *responseDict = [JSON valueForKeyPath:@"response"];
        [venue setIdVenue:(NSInteger) [responseDict objectForKey:@"id"]];
        NSLog(@"%@",JSON);
        [self checkin:venue];

    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);        
    }];
    [operation start];
}


-(IBAction)segmentedControlIndexChanged:(id)sender {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0: {
            [mapView setHidden:NO];
            [_tableView setHidden:YES];
            break;
        }
        case 1: {
            [mapView setHidden:YES];
            [_tableView setHidden:NO];
            break;
        }
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [venues count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView {
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier]; 
    
    static NSString *CellIdentifier = @"Cell";
    VenueCell *cell = (VenueCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = (VenueCell *) [[self.cellNib instantiateWithOwner:self options:nil] objectAtIndex:0];
        cell.delegate = self;
    }
    
    Venue *venue = [venues objectAtIndex:indexPath.row];
    
    cell.userData = venue;
    
    Category *category = [venue.categories objectAtIndex:0];
    
    [cell.localName setText:venue.name];
    [cell.address setText:venue.address];
    [cell.category setText: category.name];
    [cell.distance setText:[NSString stringWithFormat:@"%@%.2f%@",@"(aprox. ",venue.distance,@" km)"]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",category.iconPrefix,@"64",category.iconName]]]]; 
    [cell.imageView setImage:image];
    
//    NSLog(@"%@%@%@",category.iconPrefix,@"44",category.iconName);
    return cell;

}

-(void)viewVenueDetail:(VenueCell *)cell {
    Venue *venue = (Venue*) cell.userData;
    [self findOrCreateVenues:venue];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Venue *venue = [venues objectAtIndex:indexPath.row];
    [self findOrCreateVenues:venue];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
