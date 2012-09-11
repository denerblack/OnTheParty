//
//  User.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 02/08/12.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSInteger idUser;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *facebook;
@property (nonatomic,retain) NSString *twitter;
@property (nonatomic,retain) NSString *address;


-(User*)initWithId:(NSInteger)_idUser name:(NSString*)_name email:(NSString*)_email facebook:(NSString*)_facebook twitter:(NSString*)_twitter address:(NSString*)_address;

@end
