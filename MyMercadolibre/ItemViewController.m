//
//  ItemViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "ItemViewController.h"
#import "AFImageRequestOperation.h"
#import <QuartzCore/QuartzCore.h>

@interface ItemViewController ()

- (void)loadImages;

@end

@implementation ItemViewController

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
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320,2900)];
    
    [self loadImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImages
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img2.mlstatic.com/s_MLA_v_O_f_4122986769_042013.jpg"]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                     imageProcessingBlock:nil
                                                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                      UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                                                                      imageView.frame = CGRectMake(10, 10, 200, 200);
                                                                      imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                      imageView.layer.masksToBounds = YES;
                                                                      imageView.layer.borderColor = [UIColor blackColor].CGColor;
                                                                      imageView.layer.borderWidth = 6;
                                                                      [self.scrollView addSubview:imageView];
                                                                  } 
                                                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                      NSLog(@"%@", [error localizedDescription]);
                                                                  }];
    [operation start];
}

@end
