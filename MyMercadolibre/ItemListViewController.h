//
//  ItemListViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeliAPIHttpClient.h"

@interface ItemListViewController : UITableViewController <MeliAPIHTTPClientDelegate>

@property (strong, nonatomic) NSString *sellerId;

@property (strong, nonatomic) NSString *searchText;

@end
