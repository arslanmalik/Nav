//
//  CNPlaceTableViewCell.m
//  CoffeeNavigator
//
//  Created by Saleh Shah on 19/09/2015.
//
//

#import "CNPlaceTableViewCell.h"

@implementation CNPlaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)callButtonPressed:(id)sender {
    
    [_delegate callButtonPressedWithPlace:self.place];
}
@end
