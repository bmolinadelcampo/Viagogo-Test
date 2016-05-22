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
static NSString *const kFlagUrl = @"http://www.geonames.org/flags/x/";
NSString *const kRegionUrl = @"https://restcountries.eu/rest/v1/region/";


@interface APIController()

@property (strong, nonatomic) NSURLSession *session;
//@property (strong, nonatomic) NSMutableArray *countries;


@end

@implementation APIController

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.session = [NSURLSession sharedSession];
    }
    
    return self;
}

- (void)fetchCountriesWithCompletionHandler: (void (^)(NSArray *countries, NSError *error))completionHandler
{
    
    NSURL *url = [NSURL URLWithString:kUrl];
    
    [self fetchCountriesJsonFromUrl:url withCompletionHandler:completionHandler];
}

- (void)fetchCountriesFromRegion:(NSString *)region withCompletionHandler: (void (^)(NSArray *countries, NSError *error))completionHandler
{
    NSURL *url = [NSURL URLWithString:[kRegionUrl stringByAppendingString:[region lowercaseString]]];
    
    [self fetchCountriesJsonFromUrl:url withCompletionHandler:completionHandler];
    
}

-(void)fetchCountriesJsonFromUrl:(NSURL *)url withCompletionHandler:(void (^)(NSArray *countries, NSError *error))completionHandler
{
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
