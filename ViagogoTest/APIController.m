//
//  NetworkManager.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "APIController.h"
#import "NSLocale+LanguageCodeFinder.h"

NSString *const kUrl = @"https://restcountries.eu/rest/v1/all";
NSString *const kFlagUrl = @"http://www.geonames.org/flags/x/";

@interface APIController()

@property (strong, nonatomic) NSURLSession *session;
//@property (strong, nonatomic) NSMutableArray *countries;


@end

@implementation APIController

- (void)fetchCountriesWithCompletionHandler: (void (^)(NSArray *countries, NSError *error))completionHandler
{
    
    self.session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:kUrl];
    
    NSURLSessionDataTask *fetchJson = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSArray *countries = [self parseCountriesJsonFromData:data];
            completionHandler(countries, nil);
            
        } else {
            
            NSLog(@"%@", error);
            completionHandler(nil, error);
        }
        
    }];
    
    [fetchJson resume];
    
    return;
}

-(void)downloadImageFor:(Country *)country completionHandler:(void (^)(UIImage *flagImage, NSError *error))completionHandler
{
    
    NSURLSessionDataTask *loadimages = [[NSURLSession sharedSession] dataTaskWithURL: [self flagUrlForCountry:country] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            UIImage *flagImage = [UIImage imageWithData:data];
            country.flagImage = flagImage;
            
            completionHandler(flagImage, nil);
            
        } else {
            
            completionHandler(nil, error);
        }
    }];
    
    [loadimages resume];
}

-(NSURL *)flagUrlForCountry:(Country *)country
{
    NSString *countryCode = [country.alpha2Code lowercaseString];
    
    NSString *flagImageName = [countryCode stringByAppendingString:@".gif"];
    
    NSString *fullUrlString = [kFlagUrl stringByAppendingString:flagImageName];
    
    NSURL *fullUrl = [NSURL URLWithString:fullUrlString];
    
    NSLog(@"%@", fullUrlString);
    
    return fullUrl;
}

-(NSArray *)parseCountriesJsonFromData:(NSData *)data
{
    NSError *error;

    NSArray *jsonFeed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSMutableArray *countries = [NSMutableArray new];
    
    if (!error) {
        
        for (NSDictionary *item in jsonFeed) {
            
            Country *newCountry = [[Country alloc] initWithContentsOfDictionary:item forLanguage:[NSLocale currentLanguageCode]];
            [countries addObject:newCountry];
        }
        
        return countries;
        
    } else {
        
        return nil;
    }
}

@end
