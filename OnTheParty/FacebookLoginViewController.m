//
//  FacebookLoginViewController.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/07/12.
//
//

#import "FacebookLoginViewController.h"
#import "AppDelegate.h"

@interface FacebookLoginViewController() <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)buttonLoginHandler:(id)sender;
- (void)updateView;

@end

@implementation FacebookLoginViewController
@synthesize buttonLogin = _buttonLogin;

const NSString *URL1 = @"192.168.2.101:3000";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)findOrCreateUser:(NSDictionary<FBGraphUser> *) my {
    NSString *urlString = [NSString stringWithFormat:@"http://%@",URL1];
    NSURL *url = [NSURL URLWithString: [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:my.name,@"name",
                               [NSString stringWithFormat:@"%@", my.id], @"facebook",  nil];
    
    NSDictionary* userParams = [NSDictionary dictionaryWithObjectsAndKeys:user,@"user", nil];

    NSURLRequest *request = [httpClient  requestWithMethod:@"POST" path:@"/api/users/find_or_create" parameters:userParams];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSDictionary *responseDict = [JSON valueForKeyPath:@"response"];
        
        NSLog(@"%@",JSON);
//                UIStoryboard *mainStoryBoard = self.storyboard;
//                FirstViewController *firstViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FirstViewController"];
//                [self presentViewController:firstViewController animated:YES completion:nil];
        
        
        
    } failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON){
        NSLog(@"Failed: %@",[error localizedDescription]);
    }];
    [operation start];
    
    
    
}

-(IBAction)buttonLoginHandler:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen) {
//        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        @"select uid, name, pic_small from user where uid = me()", @"query",
//                                        nil];
//        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        @"select name,username,contact_email from user where uid in (SELECT uid2 FROM friend WHERE uid1 = me())", @"query",
//                                        nil];
//        FBRequest *request = [[FBRequest alloc] initWithSession:appDelegate.session restMethod:@"fql.query" parameters:params HTTPMethod:@"GET"];
//        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result , NSError *error) {
//            if (!error) {
//                NSLog(@"%@",result);
//            }
//        }];
        
        FBRequest *me = [[FBRequest alloc] initWithSession:appDelegate.session graphPath:@"me"] ;
        [me startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *my, NSError *error) {
            [self findOrCreateUser:my];
            NSLog(@"%@",my.id);
            [self performSegueWithIdentifier:@"tabBarController" sender:self];
//            UIStoryboard *mainStoryBoard = self.storyboard;
//            FirstViewController *firstViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"firstViewController"];
//            [self presentViewController:firstViewController animated:YES completion:nil];
        }];
        
        [appDelegate.session closeAndClearTokenInformation];
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            appDelegate.session = [[FBSession alloc] init];
            
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {

            [self updateView];
        }];
    }
    
}

-(void)updateView {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen) {
        [self.navigationController dismissModalViewControllerAnimated:YES];
    } 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateView];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self updateView];
            }];
        }
    } else {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user , NSError *error) {
            if (!error) {
                NSLog(@"%@",user.name);
            }
        }];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
