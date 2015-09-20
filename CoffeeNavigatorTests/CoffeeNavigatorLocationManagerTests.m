//
//  CoffeeNavigatorLocationManagerTests.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CNLocationManager.h"
#import "CNUtil.h"

@interface CoffeeNavigatorLocationManagerTests : XCTestCase {
    CNLocationManager *locationManager;
}

@end

@implementation CoffeeNavigatorLocationManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    locationManager = [CNLocationManager sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testManagerInstance {
    
    XCTAssertNotNil(locationManager, @"location manager is nil");
}

-(void)testUserCoordinates {
    CLLocationCoordinate2D coordinates = [locationManager getUserCoordinates];
    
    XCTAssertTrue([CNUtil validateCoordinates:coordinates], @"Location not updating properly");
    
}


@end
