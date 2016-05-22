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

-(NSDictionary *)provideDataForCountry:(Country *)country;

@end
