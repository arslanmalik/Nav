//
//  CNMapController.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import "CNMapController.h"
#import "CNPlace.h"
#import "CNUtil.h"
#import "CNPointAnnotation.h"


@interface CNMapController() <CallButtonPressedDelegate>

@property (nonatomic, strong) NSArray *places;

@end

@implementation CNMapController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configureMapToAddPlaces:(NSArray *)places {
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self removeAnnotations];
    [self addAnnotationsOnPlaces:places];
    
}

-(void)addAnnotationsOnPlaces:(NSArray *)places {
    
    for(CNPlace *place in places) {
        CNPointAnnotation *annotation = [[CNPointAnnotation alloc] init];
        annotation.title = place.name;
        annotation.subtitle = [CNUtil getFormattedDistanceStringFromDistance:place.distance];
        annotation.coordinate = place.coordinates;
        annotation.delegate = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addAnnotation:annotation];
        });
    }
}

-(void)removeAnnotations {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (id <MKAnnotation> annotation in _mapView.annotations) {
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        [annotations addObject:annotation];
    }
    
    [self.mapView removeAnnotations:annotations];
}

-(void)fitMapToShowAnnotations {
    NSArray *annotations = self.mapView.annotations;
    [self.mapView showAnnotations:annotations animated:YES];
}

#pragma mark CallButtonPressed Delegate

-(void)callButtonPressedWithPlace:(CNPlace *)place {
    [_delegate didSelectPlaceFromMap:place];
}

#pragma mark -
#pragma mark - Map Kit Delegate

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    CNPointAnnotation *pointAnnotation = (CNPointAnnotation *)annotation;
    
    MKPinAnnotationView *result = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:@"MapPlaceAnnotation"];
    
    result.pinColor = MKPinAnnotationColorRed;
    result.canShowCallout = YES;
    result.animatesDrop = YES;
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(0, 0, 40, 40);
    [callButton setImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateNormal];
    [callButton addTarget:pointAnnotation action:@selector(callButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    result.rightCalloutAccessoryView = callButton;
    
    return result;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation: (MKUserLocation *) iUserLocation {
    
    // dp any required stuff here
    NSLog(@"lat:%f, lng: %f",iUserLocation.location.coordinate.latitude, iUserLocation.location.coordinate.longitude);
  
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}



@end
