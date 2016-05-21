//
//  NetworkManager.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface APIController : NSObject

- (void)fetchCountriesWithCompletionHandler: (void (^)(NSArray *countries, NSError *error))completionHandler;

-(void)downloadImageFor:(Country *)country completionHandler:(void (^)(UIImage *flagImage, NSError *error))completionHandler;

@end
