//
//  FollowViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/16/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "FollowViewController.h"

@interface FollowViewController ()

@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@end

@implementation FollowViewController

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
	// Do any additional setup after loading the view.
    
    self.descripLabel.text = [NSString stringWithFormat:@"You are following %@ now. We will notify you everytime he publish new offers.\n\nIf you like to receive the notification on your email you can go to our web site and create an account.", self.sellerName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
