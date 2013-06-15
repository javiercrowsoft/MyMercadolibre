//
//  MasterViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/13/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeliHttpClient.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <MeliHttpClientDelegate>

@property (strong, nonatomic) NSString *nick;

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
