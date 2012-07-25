//
//  VenueCell.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VenueCell;

@protocol VenueCellDelegate <NSObject>

-(void)viewVenueDetail:(VenueCell *) venueCell;

@end

@interface VenueCell : UITableViewCell


@property(nonatomic,assign) id<VenueCellDelegate> delegate;
@property(nonatomic,strong) id userData;
@property(nonatomic,retain) IBOutlet UILabel *localName;
@property(nonatomic,retain) IBOutlet UILabel *address;
@property(nonatomic,retain) IBOutlet UILabel *category;
@property(nonatomic,retain) IBOutlet UILabel *distance;
@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UIButton *disclosureButton;

-(IBAction)viewVenueDetailAction:(id)sender;

//-(VenueCell*)initWithLocalName:(NSString*)_localName address:(NSString*)_address imageUrl:(NSString*)imageUrl;

@end
