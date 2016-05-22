//
//  CountryListDataProvider_Extension.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CountryListDataProvider.h"

@interface CountryListDataProvider (Extension)

-(void)calculateSectionsHeadersForCountries:(NSArray *)countries;

-(NSArray *)filterCountries:(NSArray *)countries forSection:(NSString *)section;

@end
