//
//  FirstViewController.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "Venue.h"
#import "Category.h"
#import "VenuesAnnotation.h"
#import "VenueCell.h"
#import "VenueCheckinViewController.h"
#import "AppDelegate.h"

@interface FirstViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,UITableViewDelegate, UITableViewDataSource,VenueCellDelegate> {
    NSMutableArray *venues;
}

@property (nonatomic,retain) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UITableView *_tableView;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;

@end
