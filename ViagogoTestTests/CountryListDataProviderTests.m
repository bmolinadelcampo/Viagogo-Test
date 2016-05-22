//
//  CountryListDataProviderTests.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 22/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CountryListDataProvider_Extension.h"
#import "Country.h"

@interface CountryListDataProviderTests : XCTestCase

@property (strong, nonatomic) CountryListDataProvider *dataProviderUT;

@end

@implementation CountryListDataProviderTests

- (void)setUp {
    [super setUp];
    
    self.dataProviderUT = [CountryListDataProvider new];
}

- (void)tearDown {
    
    self.dataProviderUT = nil;
    
    [super tearDown];
}

- (void)testSectionCalculationFromListOfCountries {
    
    NSArray *fakeCountryList = [self generateListOfFourCountries];
    
    [self.dataProviderUT calculateSectionsHeadersForCountries:fakeCountryList];
    
    NSArray *expectedSectionHeaders = @[@"A", @"R", @"S"];
    
    XCTAssertEqualObjects(self.dataProviderUT.sectionHeaders, expectedSectionHeaders, @"Country list data provider method should return expected section headers.");
    
}

- (void)testCountryFilterForSection {
    
    NSArray *fakeCountryList = [self generateListOfFourCountries];
    
    NSArray *filteredCountries = [self.dataProviderUT filterCountries:fakeCountryList forSection:@"S"];
    
    NSInteger expectedNumberOfFilteredCountries = 2;
    
    XCTAssertEqual([filteredCountries count], expectedNumberOfFilteredCountries, @"Country list data provider method should return expected number of filtered countries.");
}

-(NSArray *)generateListOfFourCountries
{
    Country *firstCountry = [Country new];
    [firstCountry setValue:@"Russia" forKey:@"name"];
    [firstCountry setValue:@"R" forKey:@"initial"];
    
    Country *secondCountry = [Country new];
    [secondCountry setValue:@"Spain" forKey:@"name"];
    [secondCountry setValue:@"S" forKey:@"initial"];
    
    Country *thirdCountry = [Country new];
    [thirdCountry setValue:@"Albania" forKey:@"name"];
    [thirdCountry setValue:@"A" forKey:@"initial"];
    
    Country *fourthCountry = [Country new];
    [fourthCountry setValue:@"Switzerland" forKey:@"name"];
    [fourthCountry setValue:@"S" forKey:@"initial"];
    
    return [NSArray arrayWithObjects:firstCountry, secondCountry, thirdCountry, fourthCountry, nil];
}

@end
