//
//  VenueCheckinViewController.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"

@interface VenueCheckinViewController : UIViewController {
    IBOutlet UILabel *labelVenueName;
}


@property (retain,nonatomic) Venue *venue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil venue:(Venue *)_venue;

@end
