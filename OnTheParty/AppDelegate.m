//
//  AppDelegate.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 28/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FacebookLoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize facebookLoginViewController = _facebookLoginViewController;
@synthesize session = _session;

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    if (!self.session.isOpen) {
////        self.facebookLoginViewController = [[FacebookLoginViewController alloc] initWithNibName:@"FacebookLoginViewController" bundle:nil];
////        self.window.rootViewController = self.facebookLoginViewController;
////        [self.window makeKeyAndVisible];
//        UIStoryboard *mainStoryBoard = self.facebookLoginViewController.storyboard;
//        self.facebookLoginViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"FacebookLoginViewController"];
//        [self.window.rootViewController presentViewController:self.facebookLoginViewController animated:YES completion:nil];
//    }
//    
//    return YES;
//}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [self.session handleOpenURL:url];
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}

@end
