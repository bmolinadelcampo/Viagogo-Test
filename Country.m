//
//  Country.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "Country.h"

@implementation Country

-(instancetype)initWithContentsOfDictionary: (NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        
        if (dictionary[@"name"]) {
            
            _name = dictionary[@"name"];
            
        }
    }
    
    return self;
}


@end
