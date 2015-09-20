//
//  CNPointAnnotation.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <MapKit/MapKit.h>

@class CNPlace;
@protocol CallButtonPressedDelegate <NSObject>

-(void)callButtonPressedWithPlace:(CNPlace *)place;

@end

@class CNPlace;
@interface CNPointAnnotation : MKPointAnnotation

@property (nonatomic, strong) CNPlace *place;
@property (nonatomic, assign) id <CallButtonPressedDelegate> delegate;

-(IBAction)callButtonPressed:(id)sender;

@end
