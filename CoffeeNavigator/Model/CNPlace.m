//
//  CNPlace.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 17/09/2015.
//
//

#import "CNPlace.h"
#import "CNConstants.h"

@implementation CNPlace

-(CNPlace *)initWithName:(NSString *)name address:(NSString *)address coordinates:(CLLocationCoordinate2D)coordinates phone:(NSNumber *)phone distance:(float)distance {
    
    self = [[CNPlace alloc] init];
    
    if (!self) {
        return nil;
    }
    
    _name = name;
    _address = address;
    _coordinates= coordinates;
    _phone= phone;
    _distance = distance;
    
    return self;
}

+(NSMutableArray *)populatePlacesWithDictionary:(NSArray *)places {
    NSMutableArray *placesArray = [[NSMutableArray alloc] init];
    
    CNPlace *place;
    for (NSDictionary *placeDict in places) {
        
        NSString *name = [placeDict objectForKey:NAME_STRING];
        
        NSDictionary *location = [placeDict objectForKey:LOCATION_STRING];
        NSString *address = [location objectForKey:ADDRESS_STRING];
        
        float lat = [[location objectForKey:LAT_STRING] floatValue];
        float lng = [[location objectForKey:LNG_STRING] floatValue];
        
        CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(lat, lng);
        float distance = [[location objectForKey:DISTANCE_STRING] floatValue];
        
        NSNumber *phone = [[placeDict objectForKey:CONTACT_STRING] objectForKey:PHONE_STRING];
        
        place = [[CNPlace alloc] initWithName:name address:address coordinates:coordinates phone:phone distance:distance];
        
        [placesArray addObject:place];
        
    }
    
    
    return placesArray;
}

@end
