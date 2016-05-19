//
//  Country.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "Country.h"

NSString *const kNameKey = @"name";
NSString *const kTranslationsKey = @"translations";

NSString *const kGermanKey = @"de";
NSString *const kSpanishKey = @"es";
NSString *const kFrenchKey = @"fr";
NSString *const kJapaneseKey = @"ja";
NSString *const kItalianKey = @"it";

NSString *const kCapitalKey = @"capital";
NSString *const kAlternativeSpellingsKey = @"altSpellings";
NSString *const kRegionKey = @"region";
NSString *const kSubregionKey = @"subregion";
NSString *const kPopulationKey = @"population";
NSString *const kCoordinatesKey = @"latlng";
NSString *const kDemonymKey = @"demonym";
NSString *const kAreaKey = @"area";
NSString *const kGiniIndexKey = @"gini";
NSString *const kTimezonesKey = @"timezones";
NSString *const kBordersKey = @"borders";
NSString *const kNativeNameKey = @"nativeName";
NSString *const kCallingCodesKey = @"callingCodes";
NSString *const kTopLevelDomainKey = @"topLevelDomain";
NSString *const kAlpha2CodeKey = @"alpha2Code";
NSString *const kAlpha3CodeKey = @"alpha3Code";
NSString *const kCurrenciesKey = @"currencies";
NSString *const kLanguagesKey = @"languages";

@implementation Country

-(instancetype)initWithContentsOfDictionary: (NSDictionary *)dictionary forLanguage:(NSString *)language
{
    self = [super init];
    
    if (self) {
        
        if (dictionary[kTranslationsKey]) {
                        
            _name = [self chooseLocalisedNameForLanguage:language fromDictionary:dictionary];
            
            if (!_name || [_name isEqual: [NSNull null]]) {
                
                _name = dictionary[kNameKey];
            }
        }
        
        if (dictionary[kCapitalKey]) {
            
            _capital = dictionary[kCapitalKey];
        }
        
        if (dictionary[kAlternativeSpellingsKey]) {
            
            _alternativeSpellingsArray = dictionary[kAlternativeSpellingsKey];
        }
        
        if (dictionary[kRegionKey]) {
            
            _region = dictionary[kRegionKey];
        }
        
        if (dictionary[kSubregionKey]) {
            
            _subregion = dictionary[kSubregionKey];
        }
        
        if (dictionary[kPopulationKey]) {
            
            _population = dictionary[kPopulationKey];
        }
        
        if (dictionary[kCoordinatesKey]) {
            
            CLLocationDegrees latitude;
            CLLocationDegrees longitude;
            
            if ([(NSArray *)dictionary[kCoordinatesKey] count] == 2) {
                
                latitude = [((NSArray *)dictionary[kCoordinatesKey])[0] doubleValue];
                longitude = [((NSArray *)dictionary[kCoordinatesKey])[1] doubleValue];
            }
            
            _coordinates = CLLocationCoordinate2DMake(latitude, longitude);

        }
        
        if (dictionary[kDemonymKey]) {
            
            _demonym = dictionary[kDemonymKey];
        }

        if (dictionary[kAreaKey]) {
            
            _area = dictionary[kAreaKey];
        }

        if (dictionary[kGiniIndexKey]) {
            
            _giniIndex = (NSInteger)dictionary[kGiniIndexKey];
        }

        if (dictionary[kTimezonesKey]) {
            
            _timeZonesArray = dictionary[kPopulationKey];
        }
        
        if (dictionary[kBordersKey]) {
            
            _bordersArray = dictionary[kBordersKey];
        }
        
        if (dictionary[kNativeNameKey]) {
            
            _nativeName = dictionary[kNativeNameKey];
        }
        
        if (dictionary[kCallingCodesKey]) {
            
            _callingCodesArray = dictionary[kPopulationKey];
        }
        
        if (dictionary[kTopLevelDomainKey]) {
            
            _topLevelDomainsArray = dictionary[kTopLevelDomainKey];
        }

        if (dictionary[kAlpha2CodeKey]) {
            
            _alpha2Code = dictionary[kAlpha2CodeKey];
        }
        
        if (dictionary[kAlpha3CodeKey]) {
            
            _alpha3Code = dictionary[kAlpha3CodeKey];
        }
        
        if (dictionary[kCurrenciesKey]) {
            
            _currenciesArray = dictionary[kCurrenciesKey];
        }
        
        if (dictionary[kLanguagesKey]) {
            
            _languagesArray = dictionary[kLanguagesKey];
        }
    }
    
    return self;
}

-(NSString *)chooseLocalisedNameForLanguage:(NSString *)language fromDictionary:(NSDictionary *)dictionary
{
    
    if ([language isEqualToString:kGermanKey]) {
        
        return ((NSDictionary *)dictionary[kTranslationsKey])[kGermanKey];
    }
    
    if ([language isEqualToString:kSpanishKey]) {
        
        return ((NSDictionary *)dictionary[kTranslationsKey])[kSpanishKey];
    }
    
    if ([language isEqualToString:kJapaneseKey]) {
        
        return ((NSDictionary *)dictionary[kTranslationsKey])[kJapaneseKey];
    }
    
    if ([language isEqualToString:kItalianKey]) {
        
        return ((NSDictionary *)dictionary[kTranslationsKey])[kItalianKey];
    }
    
    return nil;
}


@end
