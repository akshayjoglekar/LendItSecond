//
//  LendItAppDelegate.m
//  LendItSecond
//
//  Created by btm-mac on 7/31/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

NSString *const LISessionStateChangedNotification =
@"com.facebook.LendIt:LISessionStateChangedNotification";

#import "LendItAppDelegate.h"

#import "LendItViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LendItFacebookLoginViewController.h"

@implementation LendItAppDelegate

@synthesize navCon;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (void)showLoginView
{
    //UIViewController *topViewController = [self.navController topViewController];
    UIViewController *topViewController = [self.navCon topViewController];
    UIViewController *modalViewController = [topViewController modalViewController];
    
    if (![modalViewController isKindOfClass:[LendItFacebookLoginViewController class]]) {
        LendItFacebookLoginViewController* loginViewController =
        [[LendItFacebookLoginViewController alloc]initWithNibName:@"LendItFacebookLoginViewController" bundle:nil];
        [navCon presentViewController:loginViewController animated:NO completion:nil];
    } else {
        LendItFacebookLoginViewController* loginViewController =
        (LendItFacebookLoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //self.viewController = [[[LendItViewController alloc] initWithNibName:@"LendItViewController" bundle:nil] autorelease];
    //self.window.rootViewController = self.viewController;
    
    navCon = [[UINavigationController alloc] init];
    LendItViewController *livc = [[LendItViewController alloc] init];
    livc.title = @"Main menu";
    [navCon pushViewController:livc animated:NO];
    [livc release];
    [self.window setRootViewController:navCon];
    [self.window makeKeyAndVisible];
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [self openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
    return YES;
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
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController =
            [self.navCon topViewController];
            if ([[topViewController modalViewController]
                 isKindOfClass:[LendItFacebookLoginViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navCon popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:LISessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

@end
