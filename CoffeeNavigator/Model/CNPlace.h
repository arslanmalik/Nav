//
//  CNPlace.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 17/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CNPlace : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinates;
@property (nonatomic, strong) NSNumber *phone;
@property (nonatomic, readwrite) float distance;

-(CNPlace *)initWithName:(NSString *)name address:(NSString *)address coordinates:(CLLocationCoordinate2D)coordinates phone:(NSNumber *)phone distance:(float)distance;

+(NSMutableArray *)populatePlacesWithDictionary:(NSArray *)places;

@end
