//
//  Venue.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Venue.h"

@implementation Venue

@synthesize idFoursquare;
@synthesize name;
@synthesize contact;
@synthesize country;
@synthesize distance;
@synthesize latitude;
@synthesize longitude;
@synthesize categories;
@synthesize address;
@synthesize idVenue;

-(id)initWithIdFoursquare:(NSString*) _idFoursquare name:(NSString*)_name contact:(NSString*)_contact latitude:(NSString*)_latitude longitude:(NSString*)_longitude country:(NSString*)_country categories:(NSArray*)_categories {
    
    if (self = [super init]) {
        self.idFoursquare = _idFoursquare;
        self.name = _name;
        self.contact = _contact;
        self.latitude = _latitude;
        self.longitude = _longitude;
        self.country = _country;
        self.categories = _categories;
    }
    
    return self;
}

-(Venue*)initWithIdFoursquare:(NSString*) _idFoursquare name:(NSString*)_name contact:(NSString*)_contact address:(NSString*)_address latitude:(NSString*)_latitude longitude:(NSString*)_longitude distance:(double)_distance country:(NSString*)_country categories:(NSArray*)_categories {
    
    if (self = [super init]) {
        self.idFoursquare = _idFoursquare;
        self.name = _name;
        self.contact = _contact;
        self.address = _address;
        self.latitude = _latitude;
        self.longitude = _longitude;
        self.distance = _distance;
        self.country = _country;
        self.categories = _categories;
    }
    
    return self;
}

@end
