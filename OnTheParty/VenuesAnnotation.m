//
//  VenuesAnnotation.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VenuesAnnotation.h"

@implementation VenuesAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize tag;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description {
    
    if (self = [super init]) {
        coordinate = location;
        title = placeName;
        subtitle = description;        
    }
    return self;
}

@end
