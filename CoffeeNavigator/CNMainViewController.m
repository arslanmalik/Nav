//
//  ViewController.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 17/09/2015.
//
//

#import "CNMainViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "CNNetworkConstants.h"
#import "CNConstants.h"
#import "CNPlace.h"
#import "CNLocationManager.h"
#import "CNUtil.h"
#import "CNMapController.h"
#import "CNListController.h"

@interface CNMainViewController () <CNLocationDelegate,ListPlaceSelectedDelegate,MapPlaceSelectedDelegate>

-(void)getPlacesWithUserCoordinates:(CLLocationCoordinate2D) coordinates;

@property (nonatomic, strong) NSArray *places;

@end

@implementation CNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [CNLocationManager sharedManager].delegate = self;
    self.listController.delegate = self;
    self.mapController.delegate = self;
    
    [self.viewSwitchButton setTitle:SEE_PLACES_IN_MAP_TEXT forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Private Methods


-(void)getPlacesWithUserCoordinates:(CLLocationCoordinate2D) coordinates {
    
    NSString *urlString = [NSString stringWithFormat:BASE_URL,CLIENT_ID,CLIENT_SECRET,[CNUtil formattedCoordinatesStringWithCoordinates:coordinates]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.listController startActivityIndicator];
    self.viewSwitchButton.enabled = NO;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.listController stopActivityIndicator];
        self.viewSwitchButton.enabled = YES;
        
        NSDictionary *metaDictionary = [responseObject objectForKey:META_STRING];
        
        NSInteger code = [[metaDictionary objectForKey:CODE_STRING] integerValue];
        if (code != 200) {
            [self showDataError:nil];
        }
        else {
            NSArray *venues = [[responseObject objectForKey:RESPONSE_STRING] objectForKey:VENUES_STRING];
            _places = [CNUtil sortPlacesAccordingToDistanceWithPlaces:[CNPlace populatePlacesWithDictionary:venues]];
            NSLog(@"places count: %lu",(unsigned long)[self.places count]);
            
            [self.listController reloadTableViewData:self.places];
            [self.mapController configureMapToAddPlaces:self.places];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.listController stopActivityIndicator];
        
        [self showDataError:error];
    }];
    
    [operation start];
}

-(void)showDataError:(NSError *)error {
    
    NSString *errorMessage;
    if (error) {
        errorMessage = [error localizedDescription];
    }
    else {
        errorMessage = @"Request was't completed";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)viewSwitchButtonPressed:(id)sender {
    
    if (!self.listController.hidden) {
        
        self.listController.hidden = YES;
        self.mapController.hidden = NO;
        [self.mapController fitMapToShowAnnotations];
        [self.viewSwitchButton setTitle:SEE_PLACES_IN_LIST_TEXT forState:UIControlStateNormal];
    }
    else {
        self.mapController.hidden = YES;
        self.listController.hidden = NO;
        [self.viewSwitchButton setTitle:SEE_PLACES_IN_MAP_TEXT forState:UIControlStateNormal];
    }
}
- (IBAction)refreshButtonPressed:(id)sender {
    
    [self getPlacesWithUserCoordinates:[[CNLocationManager sharedManager] getUserCoordinates]];
}

-(void)callWithNumber:(NSNumber *)number {
    //NSString *phNo = [NSString stringWithFormat:@"%@",number];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",number]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *callAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [callAlert show];
    }
}

#pragma mark ListPlaceSelectedDelegate Methods

-(void)placeDidSelect:(CNPlace *)place {
    [self callWithNumber:place.phone];
}

#pragma mark MapPlaceSelectedDelegate

-(void)didSelectPlaceFromMap:(CNPlace *)place {
    [self callWithNumber:place.phone];
}
#pragma mark CNLocationDelegate Methods

-(void)userLocationDidUpdateWithCoordinates:(CLLocationCoordinate2D)coordinates {
    
    if ([CNUtil validateCoordinates:coordinates]) {
        
        if (!self.places) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self getPlacesWithUserCoordinates:coordinates];
            });
            
        }
        
    }
    
    
}
-(void)userLocationDidFailWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Unable to determine Location, using default location"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end
