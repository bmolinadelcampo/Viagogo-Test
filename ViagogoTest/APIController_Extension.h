//
//  APIController_Extension.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "APIController.h"

@interface APIController (Extension)

-(NSArray *)parseCountriesJsonFromData:(NSData *)data;

@end
