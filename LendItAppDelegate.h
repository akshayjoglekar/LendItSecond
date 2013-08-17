//
//  LendItAppDelegate.h
//  LendItSecond
//
//  Created by btm-mac on 7/31/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//
extern NSString *const LISessionStateChangedNotification;

#import <UIKit/UIKit.h>

@class LendItViewController;

@interface LendItAppDelegate : UIResponder <UIApplicationDelegate>

-(void)openSession;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LendItViewController *viewController;
@property (strong) UINavigationController *navCon;
@end
