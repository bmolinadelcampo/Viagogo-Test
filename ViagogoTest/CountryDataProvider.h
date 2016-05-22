//
//  CountryDataProvider.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

extern NSString *const kNamesSectionKey;
extern NSString *const kFlagSectionKey;
extern NSString *const kCapitalSectionKey;
extern NSString *const kLocationSectionKey;
extern NSString *const kSizeSectionKey;
extern NSString *const kBordersSectionKey;
extern NSString *const kPracticalInfoSectionKey;
extern NSString *const kOtherInfoSectionKey;

extern NSString *const kNameSubsectionKey;
extern NSString *const kNativeSpellingSubsectionKey;
extern NSString *const kAlternativeSpellingsSubsectionKey;
extern NSString *const kFlagSubsectionKey;
extern NSString *const kCapitalSubsectionKey;
extern NSString *const kRegionSubsectionKey;
extern NSString *const kSubregionSubsectionKey;
extern NSString *const kCoordinatesSubsectionKey;
extern NSString *const kAreaSubsectionKey;
extern NSString *const kPopulationSubsectionKey;
extern NSString *const kDemonymSubsectionKey;
extern NSString *const kTimezonesSubsectionKey;
extern NSString *const kLanguagesSubsectionKey;
extern NSString *const kCurrenciesSubsectionKey;
extern NSString *const kCallingCodesSubsectionKey;
extern NSString *const kGiniIndexSubsectionKey;
extern NSString *const kTopLevelDomainSubsectionKey;


@interface CountryDataProvider : NSObject

@property (strong, nonatomic) NSDictionary *countryDataDictionary;

@property (strong, nonatomic) NSArray *sections;

@property (strong, nonatomic) NSArray *subsectionsInNamesSection;
@property (strong, nonatomic) NSArray *subsectionsInLocationSection;
@property (strong, nonatomic) NSArray *subsectionsInSizeSection;
@property (strong, nonatomic) NSArray *subsectionsInPracticalInfoSection;
@property (strong, nonatomic) NSArray *subsectionsInOtherInfoSection;

-(void)provideDataForCountry:(Country *)country;

-(NSArray *)subsectionsForSection:(NSIndexPath *)indexPath;

@end
