//
//  MeliHTTPClient.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/14/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MeliHTTPClient.h"


@implementation MeliHTTPClient

+ (MeliHTTPClient *)sharedMeliHTTPClient
{
    NSString *urlStr = @"http://www.crowsoft.com.ar/cscvxi/";
    
    static dispatch_once_t pred;
    static MeliHTTPClient *_sharedMeliHTTPClient = nil;
    
    dispatch_once(&pred, ^{ _sharedMeliHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedMeliHTTPClient;
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

- (void)updateSellerListForNick:(NSString *)nick
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:nick forKey:@"nick"];
    
    [self getPath:@"profile_show.php"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if([self.delegate respondsToSelector:@selector(meliHTTPClient:didUpdateWithSellers:)])
                  [self.delegate meliHTTPClient:self didUpdateWithSellers:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if([self.delegate respondsToSelector:@selector(meliHTTPClient:didFailWithError:)])
                  [self.delegate meliHTTPClient:self didFailWithError:error];
          }];
}

@end
