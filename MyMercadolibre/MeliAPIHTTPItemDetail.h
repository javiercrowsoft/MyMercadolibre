//
//  MeliAPIHTTPItemDetail.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol MeliAPIHTTPItemDetailDelegate;

@interface MeliAPIHTTPItemDetail : AFHTTPClient

@property(weak) id<MeliAPIHTTPItemDetailDelegate> delegate;

+ (MeliAPIHTTPItemDetail *)sharedMeliAPIHTTPItemDetail;
- (void)updateItemForItemId:(NSString *)itemId;

@end

@protocol MeliAPIHTTPItemDetailDelegate <NSObject>
- (void)meliAPIHTTPItemDetail:(MeliAPIHTTPItemDetail *)client didUpdateWithItems:(id)items;
- (void)meliAPIHTTPItemDetail:(MeliAPIHTTPItemDetail *)client didFailWithError:(NSError *)error;
@end