//
//  MeliAPIHTTPClient.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol MeliAPIHTTPClientDelegate;

@interface MeliAPIHTTPClient : AFHTTPClient

@property(weak) id<MeliAPIHTTPClientDelegate> delegate;

+ (MeliAPIHTTPClient *)sharedMeliAPIHTTPClient;
- (id)initWithBaseURL:(NSURL *)url;
- (void)updateItemListForUserId:(NSString *)userId;

@end

@protocol MeliAPIHTTPClientDelegate <NSObject>
- (void)meliAPIHTTPClient:(MeliAPIHTTPClient *)client didUpdateWithItems:(id)items;
- (void)meliAPIHTTPClient:(MeliAPIHTTPClient *)client didFailWithError:(NSError *)error;
@end