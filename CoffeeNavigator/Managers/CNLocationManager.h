//
//  CNLocationManager.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CNLocationDelegate <NSObject>

-(void)userLocationDidUpdateWithCoordinates:(CLLocationCoordinate2D) coordinates;
-(void)userLocationDidFailWithError:(NSError *)error;

@end

@interface CNLocationManager : NSObject

+(CNLocationManager *)sharedManager;

-(CLLocationCoordinate2D)getUserCoordinates;

@property (nonatomic, assign) id <CNLocationDelegate> delegate;

@end
