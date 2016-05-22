//
//  Country.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "Country.h"
#import "NSObject+Null.h"

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
            
            _capital = [dictionary[kCapitalKey] nilOrObject];
            
            if (!_capital) {
                _capital = @"-";
            }
        }
        
        _alternativeSpellingsArray = [dictionary[kAlternativeSpellingsKey] nilOrObject];
        
        _region = [dictionary[kRegionKey] nilOrObject];
        
        _subregion = [dictionary[kSubregionKey] nilOrObject];
        
        _population = [dictionary[kPopulationKey] nilOrObject];
        
        if (dictionary[kCoordinatesKey]) {
            
            CLLocationDegrees latitude;
            CLLocationDegrees longitude;
            
            if ([(NSArray *)dictionary[kCoordinatesKey] count] == 2) {
                
                latitude = [((NSArray *)dictionary[kCoordinatesKey])[0] doubleValue];
                longitude = [((NSArray *)dictionary[kCoordinatesKey])[1] doubleValue];
            }
            
            _coordinates = CLLocationCoordinate2DMake(latitude, longitude);
            
        }
        
        _demonym = [dictionary[kDemonymKey] nilOrObject];
        
        _area = [dictionary[kAreaKey] nilOrObject];
        
        _giniIndex = [dictionary[kGiniIndexKey] nilOrObject];
        
        _timeZonesArray = [dictionary[kTimezonesKey] nilOrObject];
        
        _bordersArray = [dictionary[kBordersKey] nilOrObject];
        
        _nativeName = [dictionary[kNativeNameKey] nilOrObject];
        
        _callingCodesArray = [dictionary[kCallingCodesKey] nilOrObject];
        
        _topLevelDomainsArray = [dictionary[kTopLevelDomainKey] nilOrObject];
        
        _alpha2Code = [dictionary[kAlpha2CodeKey] nilOrObject];
        
        _alpha3Code = [dictionary[kAlpha3CodeKey] nilOrObject];
        
        _currenciesArray = [dictionary[kCurrenciesKey] nilOrObject];
        
        _languagesArray = [dictionary[kLanguagesKey] nilOrObject];
    }
    
    return self;
}

-(NSString *)chooseLocalisedNameForLanguage:(NSString *)language fromDictionary:(NSDictionary *)dictionary
{
    return ((NSDictionary *)dictionary[kTranslationsKey])[language];
}


@end
