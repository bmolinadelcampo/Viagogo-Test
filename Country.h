//
//  Country.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Country : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *capital;
@property (strong, nonatomic, readonly) NSArray *alternativeSpellings;
@property (strong, nonatomic, readonly) NSString *region;
@property (strong, nonatomic, readonly) NSString *subregion;
@property (strong, nonatomic, readonly) NSNumber *population;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;
@property (strong, nonatomic, readonly) NSString *demonym;
@property (strong, nonatomic, readonly) NSNumber *area;
@property (nonatomic, readonly) NSInteger giniIndex;
@property (strong, nonatomic, readonly) NSArray *timeZonesArray;
@property (strong, nonatomic, readonly) NSArray *borders;
@property (strong, nonatomic, readonly) NSString *nativeName;
@property (strong, nonatomic, readonly) NSArray *callingCodes;
@property (strong, nonatomic, readonly) NSString *topLevelDomain;
@property (strong, nonatomic, readonly) NSString *alpha2Code;
@property (strong, nonatomic, readonly) NSString *alpha3Code;
@property (strong, nonatomic, readonly) NSArray *currencies;
@property (strong, nonatomic, readonly) NSArray *languages;

-(instancetype)initWithContentsOfDictionary: (NSDictionary *)dictionary;

@end
