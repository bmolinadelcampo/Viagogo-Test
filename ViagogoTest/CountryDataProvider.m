//
//  CountryDataProvider.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryDataProvider.h"
#import "InMemoryCountriesStore.h"

@interface CountryDataProvider ()

@property (strong, nonatomic) Country *country;
@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;

@end
@implementation CountryDataProvider

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
    }
    
    return self;
}

-(NSDictionary *)provideDataForCountry:(Country *)country
{
    self.country = country;
    NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
    
    dataDictionary[@"Names"] = [self provideDataForNamesSection];
    
    dataDictionary[@"Flag"] = [self provideDataForFlagSection];
    
    dataDictionary[@"Capital"] = [self provideDataForCapitalSection];
    
    dataDictionary[@"Location"] = [self provideDataForLocationSection];
    
    dataDictionary[@"Size"] = [self provideDataForSizeSection];
    
    dataDictionary[@"Borders"] = [self provideDataForBordersSection];
    
    dataDictionary[@"Practical Info"] = [self provideDataForPracticalInfoSection];
    
    dataDictionary[@"Other Info"] = [self provideDataForOtherInfoSection];
    
    return dataDictionary;
}

-(NSDictionary *)provideDataForNamesSection
{
    NSMutableDictionary *namesSectionDictionary = [NSMutableDictionary new];
    
    namesSectionDictionary[@"Name"] = self.country.name ? : @"";
    namesSectionDictionary[@"Native Spelling"] = self.country.nativeName ? : @"";
    namesSectionDictionary[@"Alternative Spellings"] = self.country.alternativeSpellingsArray;

    return namesSectionDictionary;
}

-(NSDictionary *)provideDataForFlagSection
{
    if (self.country.flagImage) {
        return [NSDictionary dictionaryWithObject:self.country.flagImage forKey:@"Flag"];
    }
    
    return nil;
}

-(NSDictionary *)provideDataForCapitalSection
{
    return  [NSDictionary dictionaryWithObject:self.country.capital forKey:@"Capital"];
}

-(NSDictionary *)provideDataForLocationSection
{
    NSMutableDictionary *locationSectionDictionary = [NSMutableDictionary new];
    
    locationSectionDictionary[@"Region"] = self.country.region;
    locationSectionDictionary[@"Subregion"] = self.country.subregion;
    locationSectionDictionary[@"Coordinates"] = [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithDouble: self.country.coordinates.latitude], @"latitude",
                                                 [NSNumber numberWithDouble: self.country.coordinates.longitude], @"longitude",
                                                 nil];
    
    return locationSectionDictionary;
}

-(NSDictionary *)provideDataForSizeSection
{
    NSMutableDictionary *sizeSectionDictionary = [NSMutableDictionary new];
    
    sizeSectionDictionary[@"Area"] = [self.country.area.stringValue stringByAppendingString:@"km2"] ? : @"";
    sizeSectionDictionary[@"Population"] = self.country.population.stringValue ? : @"";
    
    return sizeSectionDictionary;
}

-(NSDictionary *)provideDataForBordersSection
{
    NSMutableDictionary *bordersSectionDictionary = [NSMutableDictionary new];
    
    for (NSString *border in self.country.bordersArray) {
        
        bordersSectionDictionary[border] = border;
    }
    
    return bordersSectionDictionary;
}

-(NSDictionary *)provideDataForPracticalInfoSection
{
    NSMutableDictionary *practicalInfoSectionDictionary = [NSMutableDictionary new];
    
    practicalInfoSectionDictionary[@"Demonym"] = self.country.demonym;
    practicalInfoSectionDictionary[@"Timezones"] = [self.country.timeZonesArray componentsJoinedByString:@", "] ? : @"";
    practicalInfoSectionDictionary[@"Languages"] = [self.country.languagesArray componentsJoinedByString:@", "] ? : @"";
    practicalInfoSectionDictionary[@"Currencies"] = [self.country.currenciesArray componentsJoinedByString:@", "] ? : @"";
    practicalInfoSectionDictionary[@"Calling Codes"] = [self.country.callingCodesArray componentsJoinedByString:@", "] ? : @"";
    
    return practicalInfoSectionDictionary;
}

-(NSDictionary *)provideDataForOtherInfoSection
{
    NSMutableDictionary *otherInfoSectionDictionary = [NSMutableDictionary new];
    
    otherInfoSectionDictionary[@"Gini Index"] = [self.country.giniIndex.stringValue stringByAppendingString:@"%"] ? : @"";
    otherInfoSectionDictionary[@"Top Level Domain"] = [self.country.topLevelDomainsArray componentsJoinedByString:@", "] ? : @"";
    
    return otherInfoSectionDictionary;
}

@end
