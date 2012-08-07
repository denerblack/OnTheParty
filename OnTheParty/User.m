//
//  User.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 02/08/12.
//
//

#import "User.h"

@implementation User

@synthesize email;
@synthesize name;
@synthesize idVenue;

-(User*)initWithId:(NSInteger)_idVenue name:(NSString*)_name email:(NSString*)_email {
    if (self = [super init]) {
        self.idVenue = _idVenue;
        self.name = _name;
        self.email = _email;
        
    }
    
    return self;
}

@end
