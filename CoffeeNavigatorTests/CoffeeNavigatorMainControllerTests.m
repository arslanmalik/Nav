//
//  CoffeeNavigatorTests.m
//  CoffeeNavigatorTests
//
//  Created by Arslan S. Malik on 17/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CNMainViewController.h"
#import "AppDelegate.h"
#import "CNNetworkConstants.h"
#import "CNMapController.h"
#import "CNListController.h"
#import "CNConstants.h"

@interface CoffeeNavigatorMainControllerTests : XCTestCase{
    @private
    AppDelegate *appDelegate;
    CNMainViewController *mainViewController;
    
}


@end

@implementation CoffeeNavigatorMainControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    appDelegate = nil;
    mainViewController = nil;
}

#pragma mark Nil Tests

- (void) testAppDelegate {
    XCTAssertNotNil(appDelegate, @"Cannot find the application delegate");
}

- (void) testMainViewControlle {
    XCTAssertNotNil(mainViewController, @"Cannot find the application delegate");
}

#pragma mark Data Tests

-(void)testSwitchView {
    [mainViewController view];
    
    mainViewController.mapController.hidden = YES;
    mainViewController.listController.hidden = NO;
    
    [mainViewController viewSwitchButtonPressed:nil];
    
    XCTAssertFalse(mainViewController.mapController.hidden, @"View not switched properly");
    XCTAssertTrue(mainViewController.listController.hidden, @"View not switched properly");
}

-(void)testSwitchButtonText {
    
    [mainViewController view];
    
    mainViewController.mapController.hidden = YES;
    mainViewController.listController.hidden = NO;
    
    [mainViewController viewSwitchButtonPressed:nil];
    
    NSString *switchButtonText = mainViewController.viewSwitchButton.currentTitle;
    
    XCTAssertEqual(switchButtonText, SEE_PLACES_IN_LIST_TEXT,@"Button title not updated properly");
}

@end
