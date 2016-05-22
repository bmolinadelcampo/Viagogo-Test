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

@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;
@property (strong, nonatomic) Country *country;


@end
@implementation CountryDataProvider

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
        
        [self createSectionsAndSubsections];
    }
    
    return self;
}

-(void)createSectionsAndSubsections
{
    self.sections = @[@"Names", @"Flag", @"Capital", @"Location", @"Size", @"Borders", @"Practical Info", @"Other Info"];

    self.subsectionsInNamesSection = @[@"Name", @"Native Spelling", @"Alternative Spellings"];
    
    self.subsectionsInLocationSection = @[@"Region", @"Subregion", @"Coordinates"];
    
    self.subsectionsInSizeSection = @[@"Area", @"Population"];
    
    self.subsectionsInPracticalInfoSection = @[@"Demonym", @"Timezones", @"Languages", @"Currencies", @"Calling Codes"];
    
    self.subsectionsInOtherInfoSection = @[@"Gini Index", @"Top Level Domain"];
}

-(void)provideDataForCountry:(Country *)country
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
    
    self.countryDataDictionary = dataDictionary;
}

-(NSDictionary *)provideDataForNamesSection
{
    NSMutableDictionary *namesSectionDictionary = [NSMutableDictionary new];
    
    namesSectionDictionary[@"Name"] = self.country.name;
    namesSectionDictionary[@"Native Spelling"] = self.country.nativeName;
    namesSectionDictionary[@"Alternative Spellings"] = [self.country.alternativeSpellingsArray componentsJoinedByString:@", "];
    
    self.subsectionsInNamesSection = [self removingNonExistingSubsections:self.subsectionsInNamesSection withKeys:[namesSectionDictionary allKeys]];

    return namesSectionDictionary;
}

-(NSDictionary *)provideDataForFlagSection
{
    if (self.country.flagUrlString) {
        return [NSDictionary dictionaryWithObject:self.country.flagUrlString forKey:@"FlagUrl"];
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
    locationSectionDictionary[@"Coordinates"] = [NSString stringWithFormat:@"%f°, %f°", self.country.coordinates.latitude , self.country.coordinates.longitude];
    
    self.subsectionsInLocationSection = [self removingNonExistingSubsections:self.subsectionsInLocationSection withKeys:[locationSectionDictionary allKeys]];

    return locationSectionDictionary;
}

-(NSDictionary *)provideDataForSizeSection
{
    NSMutableDictionary *sizeSectionDictionary = [NSMutableDictionary new];
    
    sizeSectionDictionary[@"Area"] = [self.country.area.stringValue stringByAppendingString:@"km2"];
    sizeSectionDictionary[@"Population"] = self.country.population.stringValue;
    
    self.subsectionsInSizeSection = [self removingNonExistingSubsections:self.subsectionsInSizeSection withKeys:[sizeSectionDictionary allKeys]];

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
    practicalInfoSectionDictionary[@"Timezones"] = [self.country.timeZonesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[@"Languages"] = [self.country.languagesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[@"Currencies"] = [self.country.currenciesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[@"Calling Codes"] = [self.country.callingCodesArray componentsJoinedByString:@", "];
    
    self.subsectionsInPracticalInfoSection = [self removingNonExistingSubsections:self.subsectionsInPracticalInfoSection withKeys:[practicalInfoSectionDictionary allKeys]];

    return practicalInfoSectionDictionary;
}

-(NSDictionary *)provideDataForOtherInfoSection
{
    NSMutableDictionary *otherInfoSectionDictionary = [NSMutableDictionary new];
    
    otherInfoSectionDictionary[@"Gini Index"] = [self.country.giniIndex.stringValue stringByAppendingString:@"%"];
    otherInfoSectionDictionary[@"Top Level Domain"] = [self.country.topLevelDomainsArray componentsJoinedByString:@", "];
    
    self.subsectionsInOtherInfoSection = [self removingNonExistingSubsections:self.subsectionsInOtherInfoSection withKeys:[otherInfoSectionDictionary allKeys]];

    return otherInfoSectionDictionary;
}

-(NSArray *)removingNonExistingSubsections:(NSArray *)subsections withKeys:(NSArray *)keys
{
    NSMutableArray *existingSubsections = [subsections mutableCopy];
    
    for (NSString *subsection in subsections) {
        
        if ([keys indexOfObject:subsection] == NSNotFound) {
            
            [existingSubsections removeObject:subsection];
        }
    }
    
    return existingSubsections;
}

@end
