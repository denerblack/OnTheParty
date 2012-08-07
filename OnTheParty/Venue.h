//
//  Venue.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Venue : NSObject

@property (nonatomic) NSInteger idVenue;
@property (nonatomic,retain) NSString *idFoursquare;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *contact;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *latitude;
@property (nonatomic,retain) NSString *longitude;
@property (nonatomic) double distance;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSArray *categories;

-(Venue*)initWithIdFoursquare:(NSString*) _idFoursquare name:(NSString*)_name contact:(NSString*)_contact latitude:(NSString*)_latitude longitude:(NSString*)_longitude country:(NSString*)_country categories:(NSArray*)_categories;

-(Venue*)initWithIdFoursquare:(NSString*) _idFoursquare name:(NSString*)_name contact:(NSString*)_contact address:(NSString*)_address latitude:(NSString*)_latitude longitude:(NSString*)_longitude distance:(double)_distance country:(NSString*)_country categories:(NSArray*)_categories;

@end
