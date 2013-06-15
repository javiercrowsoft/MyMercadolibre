//
//  MeliHTTPClient.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/14/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol MeliHTTPClientDelegate;

@interface MeliHTTPClient : AFHTTPClient

@property(weak) id<MeliHTTPClientDelegate> delegate;

+ (MeliHTTPClient *)sharedMeliHTTPClient;
- (id)initWithBaseURL:(NSURL *)url;
- (void)updateSellerListForNick:(NSString *)nick;

@end

@protocol MeliHTTPClientDelegate <NSObject>
- (void)meliHTTPClient:(MeliHTTPClient *)client didUpdateWithSellers:(id)sellers;
- (void)meliHTTPClient:(MeliHTTPClient *)client didFailWithError:(NSError *)error;
@end