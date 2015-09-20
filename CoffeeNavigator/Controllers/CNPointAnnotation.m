//
//  CNPointAnnotation.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import "CNPointAnnotation.h"

@implementation CNPointAnnotation

-(IBAction)callButtonPressed:(id)sender {
    [_delegate callButtonPressedWithPlace:self.place];
}

@end
