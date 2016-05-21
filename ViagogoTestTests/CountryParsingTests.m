//
//  CountryParsingTests.m
//  ViagogoTest
//
//  Created by Belén Molina del Campo on 21/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIController_Extension.h"
#import "Country.h"
#import <CoreLocation/CoreLocation.h>

@interface CountryParsingTests : XCTestCase

@end

@implementation CountryParsingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfParsingMethodReturnsRightNumberOfParsedObjects
{
    
    APIController *fakeApiController = [APIController new];
    
    NSArray *parsedCountriesUT = [fakeApiController parseCountriesJsonFromData:[self loadDataFromFileNamed:@"FeedWithThreeValidCountries"]];
    
    XCTAssertEqual([parsedCountriesUT count], 3, @"apiController should return 3 because json feed file has 3 valid countries");
}

- (void)testIfACountryCanBeInitializedWithDictionary
{
    NSData *data = [self loadDataFromFileNamed:@"FeedWithOneValidCountry"];
    
    NSDictionary *fakeDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *fakeLanguage = @"en";
    
    Country *countryUT = [[Country alloc] initWithContentsOfDictionary:fakeDictionary forLanguage:fakeLanguage];
    
    XCTAssertEqualObjects(countryUT.name, @"Australia", @"Name of the country should be Australia");
    
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(-27, 133);
    XCTAssertTrue(countryUT.coordinates.latitude == coordinates.latitude && countryUT.coordinates.longitude == coordinates.longitude, @"Coordinates should be (-27, 133)");

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(NSData *)loadDataFromFileNamed:(NSString *)fileName
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    
    return data;
}

@end
