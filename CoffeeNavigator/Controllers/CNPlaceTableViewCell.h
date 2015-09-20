//
//  CNPlaceTableViewCell.h
//  CoffeeNavigator
//
//  Created by Saleh Shah on 19/09/2015.
//
//

#import <UIKit/UIKit.h>

@class CNPlace;
@protocol ListCallButtonPressedDelegate <NSObject>

-(void)callButtonPressedWithPlace:(CNPlace *)place;

@end

@interface CNPlaceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (nonatomic, assign) id <ListCallButtonPressedDelegate> delegate;

@property (nonatomic, strong) CNPlace *place;

- (IBAction)callButtonPressed:(id)sender;
@end
