//
//  MeliCurrencies.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MeliCurrencies.h"

@interface MeliCurrencies ()

@property (strong, nonatomic) NSDictionary *currencies;
@property (strong, nonatomic) NSNumberFormatter *formatter;

@end

@implementation MeliCurrencies
+ (MeliCurrencies *)sharedMeliCurrencies
{
    NSString *currencies =
    @"[\
    - {\
        \"id\": \"BRL\",\
        \"description\": \"Real\",\
        \"symbol\": \"R$\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"UYU\",\
        \"description\": \"Peso Uruguayo\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"CLP\",\
        \"description\": \"Peso Chileno\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 0,\
    },\
    - {\
        \"id\": \"MXN\",\
        \"description\": \"Peso Mexicano\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"DOP\",\
        \"description\": \"Peso Dominicano\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"PAB\",\
        \"description\": \"Balboa\",\
        \"symbol\": \"B/.\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"COP\",\
        \"description\": \"Peso colombiano\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 0,\
    },\
    - {\
        \"id\": \"VEF\",\
        \"description\": \"Bolivar fuerte\",\
        \"symbol\": \"BsF\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"EUR\",\
        \"description\": \"Euro\",\
        \"symbol\": \"€\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"PEN\",\
        \"description\": \"Soles\",\
        \"symbol\": \"S/.\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"CRC\",\
        \"description\": \"Colones\",\
        \"symbol\": \"¢\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"ARS\",\
        \"description\": \"Peso argentino\",\
        \"symbol\": \"$\",\
        \"decimal_places\": 2,\
    },\
    - {\
        \"id\": \"USD\",\
        \"description\": \"Dolar\",\
        \"symbol\": \"U$S\",\
        \"decimal_places\": 2,\
    },\
    ]";
    
    static dispatch_once_t pred;
    static MeliCurrencies *_sharedMeliCurrencies = nil;
    
    dispatch_once(&pred, ^{ _sharedMeliCurrencies = [[self alloc] initWithCurrencies:currencies]; });
    return _sharedMeliCurrencies;
}

- (id)initWithCurrencies:(NSString *)currencies
{
    self = [super init];
    if (!self) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [currencies dataUsingEncoding:NSUTF8StringEncoding];
    self.currencies = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

    self.formatter = [[NSNumberFormatter alloc] init];
    [self.formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [self.formatter setGroupingSeparator:groupingSeparator];
    [self.formatter setGroupingSize:3];
    [self.formatter setAlwaysShowsDecimalSeparator:NO];
    [self.formatter setUsesGroupingSeparator:YES];
    
    return self;
}

- (NSString *) priceFromNumber:(NSNumber *)number
{
    return [self.formatter stringFromNumber:number];
}

//

@end
