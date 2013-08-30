//
//  LendStuffViewController.h
//  LendItSecond
//
//  Created by btm-mac on 7/31/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LendStuffViewController : UIViewController {
    UITextField *itemname;
    NSString *userid;
}
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextField *itemname;
//@property (strong, nonatomic) NSString *userid;

-(IBAction)textFieldReturn:(id)sender;
-(IBAction)postItem:(id)sender;
@end
