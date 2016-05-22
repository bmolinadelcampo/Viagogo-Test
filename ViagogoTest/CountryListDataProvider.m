//
//  CountryListDataProvider.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryListDataProvider.h"
#import "Country.h"

@interface CountryListDataProvider ()

@end

@implementation CountryListDataProvider

-(void)prepareDataForCountries:(NSArray *)countries
{
    self.sortedCountries = [self sortCountriesAlphabetically:countries];
    [self calculateSectionsHeadersForCountries:self.sortedCountries];
    [self createDataSourceDictionaryWithCountries:self.sortedCountries];
}

-(NSArray *)sortCountriesAlphabetically:(NSArray *)countries
{
    return [countries sortedArrayUsingComparator:^NSComparisonResult(Country *a, Country *b) {
        
        NSString *firstName = a.name;
        NSString *secondName = b.name;
        
        return [firstName compare: secondName];
    }];
}

-(void)calculateSectionsHeadersForCountries:(NSArray *)countries
{
    self.sectionHeaders = [[countries valueForKeyPath:@"@distinctUnionOfObjects.initial"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(void)createDataSourceDictionaryWithCountries:(NSArray *)countries
{
    NSMutableDictionary *dataSourceDictionary = [NSMutableDictionary new];
    
    for (NSString *section in self.sectionHeaders) {
        
        dataSourceDictionary[section] = [self filterCountries:countries forSection:section];
    }
    
    self.dataSourceDictionary = dataSourceDictionary;
}

-(NSArray *)filterCountries:(NSArray *)countries forSection:(NSString *)section
{
    NSMutableArray *countriesForSection = [NSMutableArray new];
    
    for (Country *country in countries) {
        
        if ([country.initial isEqualToString:section]) {
            
            [countriesForSection addObject:country];
        }
    }
    
    return countriesForSection;
}

@end
