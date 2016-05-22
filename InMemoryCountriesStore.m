//
//  InMemoryCountriesStore.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "InMemoryCountriesStore.h"

@interface InMemoryCountriesStore ()

@property (strong, nonatomic) NSDictionary *keyedCountries;

@end

@implementation InMemoryCountriesStore

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

-(void)setCountries:(NSArray *)countries
{
    _countries = countries;
    
    _keyedCountries = [NSDictionary dictionaryWithObjects:_countries forKeys:[_countries  valueForKey:@"alpha3Code"]];
}

-(Country *)countryForCode:(NSString *)countryCode
{
    return self.keyedCountries[countryCode];
}

@end
