//
//  CNUtil.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 19/09/2015.
//
//

#import "CNUtil.h"
#import "CNPlace.h"

@implementation CNUtil

+(float)getDistanceFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to {
    
    CLLocation * userL = [[CLLocation alloc] initWithLatitude:from.latitude longitude:from.longitude];
    CLLocation * destL = [[CLLocation alloc] initWithLatitude:to.latitude longitude:to.longitude];
    
    float distance = [userL distanceFromLocation:destL];
    
    return distance;
}

+ (BOOL)validateCoordinates:(CLLocationCoordinate2D) coordinates {
    if (coordinates.latitude == 0.0f && coordinates.longitude == 0.0f) {
        return NO;
    }
    return YES;
}

+(NSString *)formattedCoordinatesStringWithCoordinates:(CLLocationCoordinate2D) coordinates {
    return [NSString stringWithFormat:@"%f,%f",coordinates.latitude,coordinates.longitude];
}

+(NSArray *)sortPlacesAccordingToDistanceWithPlaces:(NSArray *)places {
    
    NSMutableArray * placesResult = [[NSMutableArray alloc] init];
    
    for (CNPlace *place in places) {
        
        NSUInteger newIndex = [placesResult indexOfObject:place
                                            inSortedRange:(NSRange){0, [placesResult count]}
                                                  options:NSBinarySearchingInsertionIndex
                                          usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                              CNPlace *place1 = (CNPlace*) obj1;
                                              CNPlace *place2 = (CNPlace*) obj2;
                                              if (place1.distance < place2.distance) {
                                                  return NSOrderedAscending;
                                              } else if (place1.distance > place2.distance) {
                                                  return NSOrderedDescending;
                                              } else {
                                                  return NSOrderedSame;
                                              }
                                          }];
        
        if (![placesResult containsObject:place]) {
            [placesResult insertObject:place atIndex:newIndex];
        } else {
        }
    }
    
    return placesResult;
}

+(NSString*)getFormattedDistanceStringFromDistance:(float)distance {
    
    if (distance < 1000) {
        return [NSString stringWithFormat:@"Distance: %0.0f meters", distance];
    } else {
        return [NSString stringWithFormat:@"Distance: %0.2f km", distance/1000.0f];
    }
}

@end
