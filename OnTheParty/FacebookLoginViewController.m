//
//  FacebookLoginViewController.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 30/07/12.
//
//

#import "FacebookLoginViewController.h"
#import "AppDelegate.h"

@interface FacebookLoginViewController() <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)buttonLoginHandler:(id)sender;
- (void)updateView;

@end

@implementation FacebookLoginViewController
@synthesize buttonLogin = _buttonLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)buttonLoginHandler:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user , NSError *error) {
            if (!error) {
                NSLog(@"%@",user.name);
            }
        }];
        [appDelegate.session closeAndClearTokenInformation];
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            appDelegate.session = [[FBSession alloc] init];
            
        }
        [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {

            [self updateView];
        }];
    }
    
}

-(void)updateView {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen) {
        [self.navigationController dismissModalViewControllerAnimated:YES];
    } 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateView];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            [appDelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self updateView];
            }];
        }
    } else {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user , NSError *error) {
            if (!error) {
                NSLog(@"%@",user.name);
            }
        }];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
