//
//  InMemoryCountriesStore.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface InMemoryCountriesStore : NSObject

@property (strong, nonatomic) NSArray *countries;

+ (instancetype)sharedInstance;

-(Country *)countryForCode:(NSString *)countryCode;

@end
