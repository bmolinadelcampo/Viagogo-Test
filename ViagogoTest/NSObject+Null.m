//
//  NSObject+Null.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "NSObject+Null.h"

@implementation NSObject (Null)

- (id)nilOrObject
{
    return [self isKindOfClass:[NSNull class]] ? nil : self;
}

@end
