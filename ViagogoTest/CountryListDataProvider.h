//
//  CountryListDataProvider.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryListDataProvider : NSObject

@property (strong, nonatomic) NSDictionary *dataSourceDictionary;
@property (strong, nonatomic) NSArray *sectionHeaders;
@property (strong, nonatomic) NSArray *sortedCountries; 

-(void)prepareDataForCountries:(NSArray *)countries;

@end
