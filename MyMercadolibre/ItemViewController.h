//
//  ItemViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeliAPIHTTPItemDetail.h"

@interface ItemViewController : UIViewController <MeliAPIHTTPItemDetailDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSString *itemId;

@end
