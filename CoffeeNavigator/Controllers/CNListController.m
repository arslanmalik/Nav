//
//  CNListController.m
//  CoffeeNavigator
//
//  Created by Arslan S. Malik on 18/09/2015.
//
//

#import "CNListController.h"
#import "CNPlace.h"
#import "CNUtil.h"
#import "CNPlaceTableViewCell.h"

@interface CNListController() <UITableViewDelegate, UITableViewDataSource,ListCallButtonPressedDelegate>

@end

@implementation CNListController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)reloadTableViewData:(NSArray *)places {
    
    if (places.count > 0) {
        self.places = places;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.placesTableView reloadData];
        });
    }
}

-(void)startActivityIndicator {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator startAnimating];
    });
    
}

-(void)stopActivityIndicator {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
    });
    
}

#pragma makr - CallButtonPressedDelegate

-(void)callButtonPressedWithPlace:(CNPlace *)place {
    [_delegate placeDidSelect:place];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.places count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    CNPlace *place = [self.places objectAtIndex:indexPath.row];
    cell.place = place;
    cell.nameLabel.text = place.name;
    cell.addressLabel.text = [NSString stringWithFormat:@"Address: %@",place.address];
    cell.distanceLabel.text = [CNUtil getFormattedDistanceStringFromDistance:place.distance];
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
