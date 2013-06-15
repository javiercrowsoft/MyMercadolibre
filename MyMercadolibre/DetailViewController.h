//
//  DetailViewController.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/13/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSString *sellerName;

@property (strong, nonatomic) NSString *detailItem;

@property (strong, nonatomic) NSString *sellerId;

@property (weak, nonatomic) IBOutlet UILabel *detailSellerLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
