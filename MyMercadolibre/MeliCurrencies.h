//
//  MeliCurrencies.h
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeliCurrencies : NSObject

+ (MeliCurrencies *)sharedMeliCurrencies;
- (id)initWithCurrencies:(NSString *)currencies;
- (NSString *) priceFromNumber:(NSNumber *)number;

@end
