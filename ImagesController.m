//
//  ImagesController.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ImagesController.h"

@interface ImagesController ()

@property (strong, nonatomic) NSMutableDictionary *imagesDictionary;

@end

@implementation ImagesController

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.imagesDictionary = [NSMutableDictionary new];
    }
    
    return self;
}

-(void)fetchImageWithUrl:(NSString *)urlString withCompletion:(void (^)(UIImage *image))completionHandler
{
    if (self.imagesDictionary[urlString]) {
        
        completionHandler(self.imagesDictionary[urlString]);
        
        NSLog(@"Image fetched from memory");
        
    } else {
        
        [self downloadImageWithUrl:urlString completionHandler:^(UIImage *image, NSError *error) {
            
            self.imagesDictionary[urlString] = image;
            
            completionHandler(image);
            
            NSLog(@"Image fetched from url");

        }];
    }
}

-(void)downloadImageWithUrl:(NSString *)urlString completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler
{
    
    NSURLSessionDataTask *loadImages = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString: urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            completionHandler(image, nil);
            
        } else {
            
            completionHandler(nil, error);
        }
    }];
    
    [loadImages resume];
}

@end

