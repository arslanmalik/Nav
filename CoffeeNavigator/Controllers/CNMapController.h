//
//  CNMapController.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class CNPlace;
@protocol MapPlaceSelectedDelegate <NSObject>
-(void)didSelectPlaceFromMap:(CNPlace *)place;
@end

@interface CNMapController : UIView <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) id <MapPlaceSelectedDelegate> delegate;

-(void)configureMapToAddPlaces:(NSArray *)places;
-(void)fitMapToShowAnnotations;



@end
