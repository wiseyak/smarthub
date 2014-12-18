//
//  SPGooglePlacesAutocompleteViewController.m
//  HubImpact
//
//  Created by Prakash Maharjan on 15/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "SPGooglePlacesAutocompleteViewController.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "UIViewController+ModalViewDismissOnOutsideTap.h"
#import "Constants.h"
@interface SPGooglePlacesAutocompleteViewController ()

@end

@implementation SPGooglePlacesAutocompleteViewController
@synthesize myDelegate;
@synthesize txtfield;


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // if (IS_IPAD) {
        self.view.superview.bounds = CGRectMake(0, 0, 400, 500);
        self.view.superview.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT/2));
    //}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        searchQuery.radius = 100.0;
        shouldBeginEditing = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [self.searchDisplayController.searchBar becomeFirstResponder];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    if (IOS8_OR_HIGHER)
    {
        [locationManager requestWhenInUseAuthorization];
        
    }
    else
    {
        [self fetchUserLocation];
    }

    self.searchDisplayController.searchBar.placeholder = @"Type an address for search";
}
- (void)fetchUserLocation
{
    //user location tracking
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
       // longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"long::%f",currentLocation.coordinate.longitude);
        NSLog(@"lat::%f",currentLocation.coordinate.latitude);
    }
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [searchQuery release];
    [super dealloc];
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchDisplayController.searchBar resignFirstResponder];
        NSString *place = [self placeAtIndexPath:indexPath].name;
    // [self.myDelegate secondViewControllerDismissed:place];
    [self.myDelegate secondViewControllerDismissed:place forTxtfld:txtfield];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{

    NSString *placename =@"";
    if ( self.searchDisplayController.searchBar.text.length==0) {
        placename =@"";
    }
    
    [self.myDelegate secondViewControllerDismissed:placename forTxtfld:txtfield];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    // AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    // [delegate popToFeedView];
}
#pragma mark -
#pragma mark UISearchDisplayDelegate


- (void)handleSearchForSearchString:(NSString *)searchString {
    searchQuery.input = searchString;
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Locations.");
        } else {
            [searchResultPlaces release];
            searchResultPlaces = [places retain];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

- (IBAction)CancelView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton=YES;
   
        //[self.view superview].layer.cornerRadius = CORNER_RADIUS_PRESENT_VIEW;
        [self.view superview].layer.masksToBounds = YES;
        
    
    if (IOS8_OR_HIGHER)
    {
        [locationManager requestWhenInUseAuthorization];
        
       
    }
    else
    {
        [self fetchUserLocation];
    }

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES
     ];
    //if (IS_IPAD) {
        if (self.presentingViewController) {
            [self registerForDismissOnTapOutside];
      //  }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
   // if (IS_IPAD) {
        if (self.presentingViewController) {
            [self unregisterForDismissOnTapOutside];
       // }
    }
    [super viewWillDisappear:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

@end
