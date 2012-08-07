//
//  AppDelegate.h
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBiOSSDK/FacebookSDK.h>


@class FacebookLoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FacebookLoginViewController *facebookLoginViewController;
@property (strong, nonatomic) FBSession *session;

@end
