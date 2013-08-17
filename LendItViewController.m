//
//  LendItViewController.m
//  LendItSecond
//
//  Created by btm-mac on 7/31/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

#import "LendItViewController.h"
#import "LendStuffViewController.h"
#import "LendItViewControllerTest.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LendItViewController ()

@end

@implementation LendItViewController

- (IBAction)lendStuff:(id)sender
{
    LendStuffViewController *lsvc = [[LendStuffViewController alloc] init];
    lsvc.title = @"Lend Stuff";
    [self.navigationController pushViewController:lsvc animated:YES];
    [lsvc release];
}

- (IBAction)borrowStuff:(id)sender
{
    LendItViewControllerTest *bsvc = [[LendItViewControllerTest alloc] init];
    bsvc.title = @"Borrow Stuff";
    [self.navigationController pushViewController:bsvc animated:YES];
    [bsvc release];
}

-(IBAction)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}
@end
