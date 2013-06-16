//
//  WebMeliViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/16/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "WebMeliViewController.h"

@interface WebMeliViewController ()

@end

@implementation WebMeliViewController

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
    
    NSURL *url = [NSURL URLWithString:self.permalink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
