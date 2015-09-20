//
//  CNUtil.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CNUtil : NSObject

+(float)getDistanceFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to;
+(BOOL)validateCoordinates:(CLLocationCoordinate2D) coordinates;
+(NSString *)formattedCoordinatesStringWithCoordinates:(CLLocationCoordinate2D) coordinates;
+(NSArray *)sortPlacesAccordingToDistanceWithPlaces:(NSArray *)places;
+(NSString*)getFormattedDistanceStringFromDistance:(float)distance;

@end
