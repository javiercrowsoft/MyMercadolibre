//
//  MeliHTTPClient.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/14/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol MeliHttpClientDelegate;

@interface MeliHTTPClient : AFHTTPClient

@property(weak) id<MeliHttpClientDelegate> delegate;

+ (MeliHTTPClient *)sharedMeliHTTPClient;
- (id)initWithBaseURL:(NSURL *)url;
- (void)updateSellerListForNick:(NSString *)nick;

@end

@protocol MeliHttpClientDelegate <NSObject>
- (void)meliHTTPClient:(MeliHTTPClient *)client didUpdateWithSellers:(id)sellers;
- (void)meliHTTPClient:(MeliHTTPClient *)client didFailWithError:(NSError *)error;
@end