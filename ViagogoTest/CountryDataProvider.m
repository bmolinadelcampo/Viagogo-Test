//
//  CountryDataProvider.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryDataProvider.h"
#import "InMemoryCountriesStore.h"


NSString *const kNamesSectionKey = @"names";
NSString *const kFlagSectionKey = @"flag";
NSString *const kCapitalSectionKey = @"capital";
NSString *const kLocationSectionKey = @"location";
NSString *const kSizeSectionKey = @"size";
NSString *const kBordersSectionKey = @"borders";
NSString *const kPracticalInfoSectionKey = @"practical_info";
NSString *const kOtherInfoSectionKey = @"other_info";

NSString *const kNameSubsectionKey = @"name";
NSString *const kNativeSpellingSubsectionKey = @"native_spelling";
NSString *const kAlternativeSpellingsSubsectionKey = @"alternative_spellings";
NSString *const kFlagSubsectionKey = @"flag";
NSString *const kCapitalSubsectionKey = @"capital";
NSString *const kRegionSubsectionKey = @"region";
NSString *const kSubregionSubsectionKey = @"subregion";
NSString *const kCoordinatesSubsectionKey = @"coordinates";
NSString *const kAreaSubsectionKey = @"area";
NSString *const kPopulationSubsectionKey = @"population";
NSString *const kDemonymSubsectionKey = @"demonym";
NSString *const kTimezonesSubsectionKey = @"timezones";
NSString *const kLanguagesSubsectionKey = @"languages";
NSString *const kCurrenciesSubsectionKey = @"currencies";
NSString *const kCallingCodesSubsectionKey = @"calling_codes";
NSString *const kGiniIndexSubsectionKey = @"gini_index";
NSString *const kTopLevelDomainSubsectionKey = @"top_level_domain";


@interface CountryDataProvider ()

@property (strong, nonatomic) InMemoryCountriesStore *inMemoryCountriesStore;
@property (strong, nonatomic) Country *country;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;


@end
@implementation CountryDataProvider

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.inMemoryCountriesStore = [InMemoryCountriesStore sharedInstance];
        
        [self createSectionsAndSubsections];
        
        self.numberFormatter = [NSNumberFormatter new];
        self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    
    return self;
}

-(void)createSectionsAndSubsections
{
    self.sections = @[kNamesSectionKey, kFlagSectionKey, kCapitalSectionKey, kLocationSectionKey, kSizeSectionKey, kBordersSectionKey, kPracticalInfoSectionKey, kOtherInfoSectionKey];

    self.subsectionsInNamesSection = @[kNameSubsectionKey, kNativeSpellingSubsectionKey, kAlternativeSpellingsSubsectionKey];
    
    self.subsectionsInLocationSection = @[kRegionSubsectionKey, kSubregionSubsectionKey, kCoordinatesSubsectionKey];
    
    self.subsectionsInSizeSection = @[kAreaSubsectionKey, kPopulationSubsectionKey];
    
    self.subsectionsInPracticalInfoSection = @[kDemonymSubsectionKey, kTimezonesSubsectionKey, kLanguagesSubsectionKey, kCurrenciesSubsectionKey, kCallingCodesSubsectionKey];
    
    self.subsectionsInOtherInfoSection = @[kGiniIndexSubsectionKey, kTopLevelDomainSubsectionKey];
}

-(void)provideDataForCountry:(Country *)country
{
    self.country = country;
    NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
    
    dataDictionary[kNamesSectionKey] = [self provideDataForNamesSection];
    
    dataDictionary[kFlagSectionKey] = [self provideDataForFlagSection];
    
    dataDictionary[kCapitalSectionKey] = [self provideDataForCapitalSection];
    
    dataDictionary[kLocationSectionKey] = [self provideDataForLocationSection];
    
    dataDictionary[kSizeSectionKey] = [self provideDataForSizeSection];
    
    dataDictionary[kBordersSectionKey] = [self provideDataForBordersSection];
    
    dataDictionary[kPracticalInfoSectionKey] = [self provideDataForPracticalInfoSection];
    
    dataDictionary[kOtherInfoSectionKey] = [self provideDataForOtherInfoSection];
    
    self.countryDataDictionary = dataDictionary;
}

-(NSDictionary *)provideDataForNamesSection
{
    NSMutableDictionary *namesSectionDictionary = [NSMutableDictionary new];
    
    namesSectionDictionary[kNameSubsectionKey] = self.country.name;
    namesSectionDictionary[kNativeSpellingSubsectionKey] = self.country.nativeName;
    namesSectionDictionary[kAlternativeSpellingsSubsectionKey] = [self.country.alternativeSpellingsArray componentsJoinedByString:@", "];
    
    self.subsectionsInNamesSection = [self removingNonExistingSubsections:self.subsectionsInNamesSection withKeys:[namesSectionDictionary allKeys]];

    return namesSectionDictionary;
}

-(NSDictionary *)provideDataForFlagSection
{
    if (self.country.flagUrlString) {
        return [NSDictionary dictionaryWithObject:self.country.flagUrlString forKey:kFlagSubsectionKey];
    }
    
    return nil;
}

-(NSDictionary *)provideDataForCapitalSection
{
    return  [NSDictionary dictionaryWithObject:self.country.capital forKey:kCapitalSubsectionKey];
}

-(NSDictionary *)provideDataForLocationSection
{
    NSMutableDictionary *locationSectionDictionary = [NSMutableDictionary new];
    
    locationSectionDictionary[kRegionSubsectionKey] = self.country.region;
    locationSectionDictionary[kSubregionSubsectionKey] = self.country.subregion;
    locationSectionDictionary[kCoordinatesSubsectionKey] = [NSString stringWithFormat:@"%f°, %f°", self.country.coordinates.latitude , self.country.coordinates.longitude];
    
    self.subsectionsInLocationSection = [self removingNonExistingSubsections:self.subsectionsInLocationSection withKeys:[locationSectionDictionary allKeys]];

    return locationSectionDictionary;
}

-(NSDictionary *)provideDataForSizeSection
{
    NSMutableDictionary *sizeSectionDictionary = [NSMutableDictionary new];
    
    sizeSectionDictionary[kAreaSubsectionKey] = [[self.numberFormatter stringFromNumber: self.country.area ] stringByAppendingString:@" km2"];
    sizeSectionDictionary[kPopulationSubsectionKey] = [self.numberFormatter stringFromNumber:self.country.population];
    
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
    
    practicalInfoSectionDictionary[kDemonymSubsectionKey] = self.country.demonym;
    practicalInfoSectionDictionary[kTimezonesSubsectionKey] = [self.country.timeZonesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[kLanguagesSubsectionKey] = [self.country.languagesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[kCurrenciesSubsectionKey] = [self.country.currenciesArray componentsJoinedByString:@", "];
    practicalInfoSectionDictionary[kCallingCodesSubsectionKey] = [self.country.callingCodesArray componentsJoinedByString:@", "];
    
    self.subsectionsInPracticalInfoSection = [self removingNonExistingSubsections:self.subsectionsInPracticalInfoSection withKeys:[practicalInfoSectionDictionary allKeys]];

    return practicalInfoSectionDictionary;
}

-(NSDictionary *)provideDataForOtherInfoSection
{
    NSMutableDictionary *otherInfoSectionDictionary = [NSMutableDictionary new];
    
    otherInfoSectionDictionary[kGiniIndexSubsectionKey] = [self.country.giniIndex.stringValue stringByAppendingString:@"%"];
    otherInfoSectionDictionary[kTopLevelDomainSubsectionKey] = [self.country.topLevelDomainsArray componentsJoinedByString:@", "];
    
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

-(NSArray *)subsectionsForSection:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            return self.subsectionsInNamesSection;
            
        case 3:
            return self.subsectionsInLocationSection;
        
        case 4:
            return self.subsectionsInSizeSection;
            
        case 6:
            return self.subsectionsInPracticalInfoSection;
            
        case 7:
            return self.subsectionsInOtherInfoSection;
        
        default:
            return nil;
    }
}

@end
