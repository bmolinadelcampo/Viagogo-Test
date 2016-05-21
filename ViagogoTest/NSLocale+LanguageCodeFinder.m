//
//  LanguageFinder.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 20/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "NSLocale+LanguageCodeFinder.h"

@implementation NSLocale(languageCodeFinder)

+(NSString *)currentLanguageCode
{
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];
    
    NSString *languageCode = [languageDic objectForKey: @"kCFLocaleLanguageCodeKey"];
    
    return languageCode;
}

@end
