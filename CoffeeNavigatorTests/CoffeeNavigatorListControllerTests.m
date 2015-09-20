//
//  CoffeeNavigatorListControllerTests.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CNListController.h"
#import "CNMainViewController.h"
#import "CNPlace.h"
#import <CoreLocation/CoreLocation.h>

@interface CoffeeNavigatorListControllerTests : XCTestCase {
    CNListController *listController;
    CNMainViewController *mainViewController;
}

@end

@implementation CoffeeNavigatorListControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [mainViewController view];
    listController = mainViewController.listController;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    mainViewController = nil;
    listController = nil;
}

-(void)testPopulateList {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    [listController reloadTableViewData:places];
    
    XCTAssertEqual([listController.places count] , 0, @"Places should not be populated from an empty array");
    
    NSString *name = @"My coffee place";
    NSString *address = @"77 C, Middle of no where";
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(51.4534, -0.565);
    NSNumber *phone = [NSNumber numberWithInteger:3232123];
    float distance = 786;
    
    CNPlace *place = [[CNPlace alloc] initWithName:name address:address coordinates:coordinates phone:phone distance:distance];
    
    [places addObject:place];
    
    [listController reloadTableViewData:places];
    
    XCTAssertGreaterThan([listController.places count] , 0, @"Places should not be empty");
    
    
}


@end
