//
//  CoffeeNavigatorUtilTests.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "CNUtil.h"
#import "CNPlace.h"

@interface CoffeeNavigatorUtilTests : XCTestCase

@end

@implementation CoffeeNavigatorUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testValidateCoordinates {
    
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(0.0f, 0.0f);
    
    BOOL check = [CNUtil validateCoordinates:coordinates];
    
    XCTAssertFalse(check, @"Pass");
    
    
    coordinates = CLLocationCoordinate2DMake(0.5f, -0.8f);
    
    check = [CNUtil validateCoordinates:coordinates];
    
    XCTAssertTrue(check, @"Pass");
    
}

-(void)testPlacesSort {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    NSString *name = @"My coffee place";
    NSString *address = @"77 C, Middle of no where";
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(51.4534, -0.565);
    NSNumber *phone = [NSNumber numberWithInteger:3232123];
    float distance = 789;
    
    CNPlace *place = [[CNPlace alloc] initWithName:name address:address coordinates:coordinates phone:phone distance:distance];
    
    [places addObject:place];
    
    name = @"Your coffee place";
    address = @"78 C, Middle of no where";
    coordinates = CLLocationCoordinate2DMake(52.4534, -0.565);
    phone = [NSNumber numberWithInteger:3234324];
    distance = 788;
    place = [[CNPlace alloc] initWithName:name address:address coordinates:coordinates phone:phone distance:distance];
    
    [places addObject:place];
    
    NSArray *resultPlaces = [CNUtil sortPlacesAccordingToDistanceWithPlaces:places];
    
    place = [resultPlaces objectAtIndex:0];
    
    XCTAssertEqual(place.distance, 788, @"Not sorted properly");

}


@end
