//
//  MeliAPIHTTPUser.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/16/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol MeliAPIHTTPUserDelegate;

@interface MeliAPIHTTPUser : AFHTTPClient

@property(weak) id<MeliAPIHTTPUserDelegate> delegate;

+ (MeliAPIHTTPUser *)sharedMeliAPIHTTPUser;
- (void)updateSellerForSellerId:(NSString *)sellerId;

@end

@protocol MeliAPIHTTPUserDelegate <NSObject>
- (void)meliAPIHTTPUser:(MeliAPIHTTPUser *)client didUpdateWithSeller:(id)seller;
- (void)meliAPIHTTPUser:(MeliAPIHTTPUser *)client didFailWithError:(NSError *)error;
@end