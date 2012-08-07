//
//  User.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 02/08/12.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSInteger idVenue;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *email;


-(User*)initWithId:(NSInteger)_idVenue name:(NSString*)_name email:(NSString*)_email;

@end
