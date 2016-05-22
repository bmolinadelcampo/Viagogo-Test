//
//  Country.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Country : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *capital;
@property (strong, nonatomic, readonly) NSArray *alternativeSpellingsArray;
@property (strong, nonatomic, readonly) NSString *region;
@property (strong, nonatomic, readonly) NSString *subregion;
@property (strong, nonatomic, readonly) NSNumber *population;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;
@property (strong, nonatomic, readonly) NSString *demonym;
@property (strong, nonatomic, readonly) NSNumber *area;
@property (nonatomic, readonly) NSNumber *giniIndex;
@property (strong, nonatomic, readonly) NSArray *timeZonesArray;
@property (strong, nonatomic, readonly) NSArray *bordersArray;
@property (strong, nonatomic, readonly) NSString *nativeName;
@property (strong, nonatomic, readonly) NSArray *callingCodesArray;
@property (strong, nonatomic, readonly) NSArray *topLevelDomainsArray;
@property (strong, nonatomic, readonly) NSString *alpha2Code;
@property (strong, nonatomic, readonly) NSString *alpha3Code;
@property (strong, nonatomic, readonly) NSArray *currenciesArray;
@property (strong, nonatomic, readonly) NSArray *languagesArray;

@property (strong, nonatomic) NSString *flagUrlString;
@property (strong, nonatomic) UIImage *flagImage;

@property (strong, nonatomic) NSString *initial;

-(instancetype)initWithContentsOfDictionary: (NSDictionary *)dictionary forLanguage:(NSString *)language;

@end
