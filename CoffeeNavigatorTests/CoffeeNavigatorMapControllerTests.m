//
//  CoffeeNavigatorMapControllerTests.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CNMapController.h"
#import "CNMainViewController.h"
#import "CNPlace.h"

@interface CoffeeNavigatorMapControllerTests : XCTestCase {
    CNMapController *mapController;
    CNMainViewController *mainViewController;
}

@end

@implementation CoffeeNavigatorMapControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [mainViewController view];
    mapController = mainViewController.mapController;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    mapController = nil;
    mainViewController = nil;
}

- (void)testAnnotations {

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
    
    [mapController configureMapToAddPlaces:places];
    
    NSArray *annotations = mapController.mapView.annotations;
    
    XCTAssertEqual([annotations count], 0, @"Annotations not added");
}


@end
