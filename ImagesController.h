//
//  ImagesController.h
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagesController : NSObject

+ (instancetype)sharedInstance;

-(void)fetchImageWithUrl:(NSString *)url withCompletion:(void (^)(UIImage *image))completionHandler;

@end
