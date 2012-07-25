//
//  Category.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Category.h"

@implementation Category
@synthesize name;
@synthesize idFoursquare;
@synthesize iconName;
@synthesize shortName;
@synthesize iconPrefix;
@synthesize pluralName;

-(Category*)initWithIdFoursquare:(NSString*)_idFoursquare name:(NSString*)_name pluralName:(NSString*)_pluralName shortName:(NSString*)_shortName iconPrefix:(NSString*)_iconPrefix iconName:(NSString*)_iconName{
    if (self = [super init]) {
        self.idFoursquare = _idFoursquare;
        self.name = _name;
        self.pluralName = _pluralName;
        self.shortName = _shortName;
        self.iconPrefix = _iconPrefix;
        self.iconName = _iconName;
        
    }
    
    return self;
}

@end
