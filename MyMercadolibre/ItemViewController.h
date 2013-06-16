//
//  ItemViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeliAPIHTTPItemDetail.h"
#import "MeliAPIHTTPUser.h"

@interface ItemViewController : UIViewController <MeliAPIHTTPItemDetailDelegate, MeliAPIHTTPUserDelegate>

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) NSString *sellerName;

@end
