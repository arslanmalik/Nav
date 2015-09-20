//
//  CNLocationManager.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import "CNLocationManager.h"

@interface CNLocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite) CLLocationCoordinate2D userCoordinates;

-(void)initialize;

@end

@implementation CNLocationManager

+ (CNLocationManager *) sharedManager {
    static CNLocationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(id)init {
    
    self = [super init];
    
    if (self == nil) { return nil; }
    
    [self initialize];
    
    return self;
    
}

-(void)initialize {
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.locationManager startUpdatingLocation];
}

-(CLLocationCoordinate2D)getUserCoordinates {
    return self.userCoordinates;
}

#pragma mark LocationDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    self.userCoordinates = location.coordinate;
    
    [_delegate userLocationDidUpdateWithCoordinates:location.coordinate];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [_delegate userLocationDidFailWithError:error];
}


@end
