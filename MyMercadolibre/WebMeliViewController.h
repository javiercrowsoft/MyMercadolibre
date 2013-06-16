//
//  WebMeliViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/16/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebMeliViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *permalink;

@end
