//
//  CountryDataProvider.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface CountryDataProvider : NSObject

@property (strong, nonatomic) NSArray *sections;

@property (strong, nonatomic) NSArray *subsectionsInNamesSection;
@property (strong, nonatomic) NSArray *subsectionsInLocationSection;
@property (strong, nonatomic) NSArray *subsectionsInSizeSection;
@property (strong, nonatomic) NSArray *subsectionsInPracticalInfoSection;
@property (strong, nonatomic) NSArray *subsectionsInOtherInfoSection;

-(NSDictionary *)provideDataForCountry:(Country *)country;

@end
