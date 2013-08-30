//
//  LendStuffViewController.m
//  LendItSecond
//
//  Created by btm-mac on 7/31/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

#import "LendStuffViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LendItAppDelegate.h"

@interface LendStuffViewController ()

@end

@implementation LendStuffViewController
@synthesize itemname;

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:LISessionStateChangedNotification
     object:nil];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.usernameLabel.text = user.id;
                 userid = user.id;
                 //self.userProfileImage.profileID = user.id;
             }
         }];
    }
}


-(IBAction)postItem:(id)sender;
{
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/postitem?itemname=%@&username=%@", self.itemname.text, @"userid"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Fetch the response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    // Construct a String around the Data from the response
    NSString * alertMessage = @"Your item has been successfully posted";
    NSString *responseString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"Invoked URL. responseString = %@", responseString);

    if([responseString rangeOfString:@"ErrorCode=0"].location == NSNotFound) {
        alertMessage = @"There was an error posting your item. Please try again later";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:alertMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

@end
