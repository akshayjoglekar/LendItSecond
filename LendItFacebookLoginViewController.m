//
//  LendItFacebookLoginViewController.m
//  LendItSecond
//
//  Created by btm-mac on 8/4/13.
//  Copyright (c) 2013 btm-mac. All rights reserved.
//

#import "LendItFacebookLoginViewController.h"
#import "LendItAppDelegate.h"

@interface LendItFacebookLoginViewController ()
@property(strong, nonatomic) IBOutlet
UIActivityIndicatorView *spinner;

@end

@implementation LendItFacebookLoginViewController

@synthesize spinner;

- (IBAction)performLogin:(id)sender
{
    [self.spinner startAnimating];
    
    LendItAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
