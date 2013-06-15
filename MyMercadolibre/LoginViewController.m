//
//  LoginViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/14/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "LoginViewController.h"

#import "MasterViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nickText;

@end

@implementation LoginViewController

- (void)setup
{
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMaster"]) {
        [[segue destinationViewController] setNick:self.nickText.text];
    }
}

#pragma mark - Input

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
