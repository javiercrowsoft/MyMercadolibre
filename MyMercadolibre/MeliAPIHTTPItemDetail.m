//
//  MeliAPIHTTPItemDetail.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MeliAPIHTTPItemDetail.h"

@implementation MeliAPIHTTPItemDetail

+ (MeliAPIHTTPItemDetail *)sharedMeliAPIHTTPItemDetail
{
    NSString *urlStr = @"https://api.mercadolibre.com/items/";
    
    static dispatch_once_t pred;
    static MeliAPIHTTPItemDetail *_sharedMeliAPIHTTPItemDetail = nil;
    
    dispatch_once(&pred, ^{ _sharedMeliAPIHTTPItemDetail = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedMeliAPIHTTPItemDetail;
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

- (void)updateItemForItemId:(NSString *)itemId
{
    [self getPath:itemId
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPItemDetail:didUpdateWithItems:)])
                  [self.delegate meliAPIHTTPItemDetail:self didUpdateWithItems:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPItemDetail:didFailWithError:)])
                  [self.delegate meliAPIHTTPItemDetail:self didFailWithError:error];
          }];
}

@end
