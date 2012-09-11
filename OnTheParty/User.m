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
@synthesize idUser;
@synthesize facebook;
@synthesize twitter;
@synthesize address;

-(User*)initWithId:(NSInteger)_idUser name:(NSString*)_name email:(NSString*)_email facebook:(NSString*)_facebook twitter:(NSString*)_twitter address:(NSString*)_address {
    if (self = [super init]) {
        self.idUser = _idUser;
        self.name = _name;
        self.email = _email;
        self.facebook = _facebook;
        self.twitter = _twitter;
        self.address = _address;
    }
    
    return self;
}

@end
