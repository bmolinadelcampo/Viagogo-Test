//
//  NetworkManager.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 19/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "NetworkManager.h"
#import "Country.h"

NSString *const kUrl = @"https://restcountries.eu/rest/v1/all";

@interface NetworkManager()

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSMutableArray *countries;


@end

@implementation NetworkManager

- (void)fetchCountriesWithCompletionHandler: (void (^)(NSArray *countries, NSError *error))completionHandler
{
    
    self.countries = [NSMutableArray new];
    
    self.session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:kUrl];
    
    NSURLSessionDataTask *fetchJson = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *jsonError;
            
            NSArray *jsonFeed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError) {
                
                for (NSDictionary *item in jsonFeed) {
                    
                    Country *newCountry = [[Country alloc] initWithContentsOfDictionary:item forLanguage:[self findLanguageCode]];
                    [self.countries addObject:newCountry];
                }
                
                completionHandler(self.countries, nil);

            } else {
                
                completionHandler(nil, jsonError);
            }
            
        } else {
            
            NSLog(@"%@", error);
            completionHandler(nil, error);
        }
    }];
    
    [fetchJson resume];
    
    return;
}

-(NSString *)findLanguageCode
{
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];
    
    NSString *languageCode = [languageDic objectForKey: @"kCFLocaleLanguageCodeKey"];
    
    return languageCode;
}

@end
