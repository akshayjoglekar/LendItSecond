//
//  LendItFacebookLoginViewController.h
//  LendItSecond
//
//  Created by btm-mac on 8/4/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LendItFacebookLoginViewController : UIViewController

-(IBAction)performLogin:(id)sender;
- (void)loginFailed;
@end
