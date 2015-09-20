//
//  CNListController.h
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import <UIKit/UIKit.h>

@class CNPlace;
@protocol ListPlaceSelectedDelegate <NSObject>

-(void)placeDidSelect:(CNPlace *)place;

@end

@interface CNListController : UIView 

@property (nonatomic, strong) IBOutlet UITableView *placesTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSArray *places;
@property (nonatomic, assign) id <ListPlaceSelectedDelegate> delegate;

-(void)reloadTableViewData:(NSArray *)places;
-(void)startActivityIndicator;
-(void)stopActivityIndicator;

@end
