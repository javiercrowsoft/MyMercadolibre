//
//  MeliAPIHTTPClient.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MeliAPIHTTPClient.h"

@implementation MeliAPIHTTPClient

+ (MeliAPIHTTPClient *)sharedMeliAPIHTTPClient
{
    NSString *urlStr = @"https://api.mercadolibre.com/sites/MLA/";
    
    static dispatch_once_t pred;
    static MeliAPIHTTPClient *_sharedMeliAPIHTTPClient = nil;
    
    dispatch_once(&pred, ^{ _sharedMeliAPIHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedMeliAPIHTTPClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (void)updateItemListForUserId:(NSString *)userId
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userId forKey:@"seller_id"];
    
    [self getPath:@"search"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPClient:didUpdateWithItems:)])
                  [self.delegate meliAPIHTTPClient:self didUpdateWithItems:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPClient:didFailWithError:)])
                  [self.delegate meliAPIHTTPClient:self didFailWithError:error];
          }];
}

- (void)updateItemListForText:(NSString *)searchText
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:searchText forKey:@"q"];
    
    [self getPath:@"search"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPClient:didUpdateWithItems:)])
                  [self.delegate meliAPIHTTPClient:self didUpdateWithItems:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPClient:didFailWithError:)])
                  [self.delegate meliAPIHTTPClient:self didFailWithError:error];
          }];
}

@end

