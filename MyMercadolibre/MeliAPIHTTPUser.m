//
//  MeliAPIHTTPUser.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/16/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MeliAPIHTTPUser.h"

@implementation MeliAPIHTTPUser

+ (MeliAPIHTTPUser *)sharedMeliAPIHTTPUser
{
    NSString *urlStr = @"https://api.mercadolibre.com/users/";
    
    static dispatch_once_t pred;
    static MeliAPIHTTPUser *_sharedMeliAPIHTTPUser = nil;
    
    dispatch_once(&pred, ^{ _sharedMeliAPIHTTPUser = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedMeliAPIHTTPUser;
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

- (void)updateSellerForSellerId:(NSString *)sellerId
{
    [self getPath:sellerId
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPUser:didUpdateWithSeller:)])
                  [self.delegate meliAPIHTTPUser:self didUpdateWithSeller:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(meliAPIHTTPUser:didFailWithError:)])
                  [self.delegate meliAPIHTTPUser:self didFailWithError:error];
          }];
}

@end
