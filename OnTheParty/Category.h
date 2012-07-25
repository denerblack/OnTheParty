//
//  Category.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Category : NSObject

@property (nonatomic,retain) NSString *idFoursquare;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *pluralName;
@property (nonatomic,retain) NSString *shortName;
@property (nonatomic,retain) NSString *iconPrefix;
@property (nonatomic,retain) NSString *iconName;

-(Category*)initWithIdFoursquare:(NSString*)_idFoursquare name:(NSString*)_name pluralName:(NSString*)_pluralName shortName:(NSString*)_shortName iconPrefix:(NSString*)_iconPrefix iconName:(NSString*)_iconName;
@end
