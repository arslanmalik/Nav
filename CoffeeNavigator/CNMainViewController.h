//
//  ViewController.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 17/09/2015.
//
//

#import <UIKit/UIKit.h>

@class CNMapController;
@class CNListController;
@interface CNMainViewController : UIViewController

@property (nonatomic, strong) IBOutlet CNMapController *mapController;
@property (nonatomic, strong) IBOutlet CNListController *listController;
@property (weak, nonatomic) IBOutlet UIButton *viewSwitchButton;

- (IBAction)viewSwitchButtonPressed:(id)sender;
- (IBAction)refreshButtonPressed:(id)sender;

@end

