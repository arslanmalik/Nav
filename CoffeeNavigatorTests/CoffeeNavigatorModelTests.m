//
//  CoffeeNavigatorModelTests.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CNPlace.h"
#import "CNConstants.h"

@interface CoffeeNavigatorModelTests : XCTestCase {
    NSDictionary *responseDictionary;
}

@end

@implementation CoffeeNavigatorModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"sample-response" ofType:@"json"];
    
    NSData *sampleData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    
    // 5
    id json = [NSJSONSerialization JSONObjectWithData:sampleData
                                              options:kNilOptions
                                                error:&error];
    
    responseDictionary = json;
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    responseDictionary = nil;
}

-(void)testPlace {
    
    NSString *name = @"My coffee place";
    NSString *address = @"77 C, Middle of no where";
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(51.4534, -0.565);
    NSNumber *phone = [NSNumber numberWithInteger:3232123];
    float distance = 789;
    
    CNPlace *place = [[CNPlace alloc] initWithName:name address:address coordinates:coordinates phone:phone distance:distance];
    
    XCTAssertNotNil(place, @"Place has not been allocated properly");
    
    if (![place.name isEqualToString:name]) {
        
        XCTAssertFalse(@"Properties have not been set properly");
        
    }
    
}

-(void)testSampleJSON {
    
    XCTAssertNotNil(responseDictionary, @"invalid test data");
    
}

-(void)testDataPopulation {
    
    NSArray *placesDictionary = [[responseDictionary objectForKey:RESPONSE_STRING] objectForKey:VENUES_STRING];
    
    NSMutableArray *places = [CNPlace populatePlacesWithDictionary:placesDictionary];
    
    XCTAssertNotEqual([places count], 0, @"Places have not been populated properly");
    
}



@end
