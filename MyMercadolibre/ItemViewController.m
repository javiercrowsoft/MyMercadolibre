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

@property(strong, nonatomic) NSDictionary *response;
@property(nonatomic) float rotation;
@property(nonatomic) NSInteger pictureLoadedCount;
@property(nonatomic) NSInteger pictureCount;
@property(nonatomic) NSInteger pictureSelected;
@property(strong, nonatomic) NSMutableArray *pictures;

- (void)getItem;
- (void)loadImages;
- (void)loadAnImageFromUrl:(NSString *)imageUrl;

- (void)attachSwipeGestureToView:(UIView *)view;
- (void)handleSwipe:(UITapGestureRecognizer *)recognizer;

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

    self.rotation = 0;
    self.pictureLoadedCount = 0;
    self.pictureCount = 0;
    self.pictures = [[NSMutableArray alloc] init];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320,2900)];
    
    [self getItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Implementation

- (void)meliAPIHTTPItemDetail:(MeliAPIHTTPItemDetail *)client didUpdateWithItems:(id)items
{
    self.response = items;
    [self loadImages];
}

- (void)meliAPIHTTPItemDetail:(MeliAPIHTTPItemDetail *)client didFailWithError:(NSError *)error
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Items for a Seller"
                                                 message:[NSString stringWithFormat:@"%@",error]
                                                delegate:nil
                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

#pragma mark - get content from Meli

- (void)getItem
{
    self.pictureCount = 0;
    self.pictureLoadedCount = 0;
    MeliAPIHTTPItemDetail *client = [MeliAPIHTTPItemDetail sharedMeliAPIHTTPItemDetail];
    client.delegate = self;
    [client updateItemForItemId:self.itemId];
}

- (void)loadImages
{
    
    NSArray *pictures = [self.response objectForKey:@"pictures"];
    self.pictureCount = [pictures count];
    for (id picture in pictures) {
        NSString *url = [picture objectForKey:@"url"];
        [self loadAnImageFromUrl:url];
    }
}

- (void)loadAnImageFromUrl:(NSString *)imageUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                     imageProcessingBlock:nil
                                                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                      self.rotation += 0.05;
                                                                      UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                                                                      imageView.frame = CGRectMake(50, 20, 200, 200);
                                                                      imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                                      imageView.layer.masksToBounds = YES;
                                                                      imageView.layer.borderColor = [UIColor blackColor].CGColor;
                                                                      imageView.backgroundColor = [UIColor whiteColor];
                                                                      imageView.layer.borderWidth = 3;
                                                                      self.pictureLoadedCount += 1;
                                                                      if (self.pictureLoadedCount < self.pictureCount) {
                                                                          imageView.transform = CGAffineTransformMakeRotation(self.rotation);
                                                                      }
                                                                      [self.pictures addObject:imageView];
                                                                      [self.scrollView addSubview:imageView];
                                                                      [self attachSwipeGestureToView:imageView];
                                                                      self.pictureSelected = self.pictureLoadedCount;
                                                                      imageView.userInteractionEnabled = YES;
                                                                  }
                                                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                      NSLog(@"%@", [error localizedDescription]);
                                                                  }];
    [operation start];

}

- (void)attachSwipeGestureToView:(UIView *)view
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:oneFingerSwipeUp];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    UIImageView *currentImageView = [self.pictures objectAtIndex:self.pictureSelected -1];
    self.pictureSelected -= 1;
    if (self.pictureSelected < 1) {
        self.pictureSelected = self.pictureLoadedCount;
    }
    UIImageView *imageView = [self.pictures objectAtIndex:self.pictureSelected -1];
    self.rotation += 0.05;
    if (self.rotation > 0.25) {
        self.rotation = 0.05;
    }
    currentImageView.transform = CGAffineTransformMakeRotation(self.rotation);
    [self.scrollView bringSubviewToFront:imageView];
    imageView.transform = CGAffineTransformMakeRotation(0);
}

@end
