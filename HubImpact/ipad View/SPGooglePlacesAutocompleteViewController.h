//
//  SPGooglePlacesAutocompleteViewController.h
//  HubImpact
//
//  Created by Prakash Maharjan on 15/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
@class SPGooglePlacesAutocompleteQuery;

@protocol SecondsDelegate <NSObject>

-(void) secondViewControllerDismissed:(NSString *)stringForFirst forTxtfld:(UITextField *)txt;
@end

@interface SPGooglePlacesAutocompleteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate,CLLocationManagerDelegate> {
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    BOOL shouldBeginEditing;
    CLLocationManager *locationManager;
}

@property (nonatomic, assign) id<SecondsDelegate>    myDelegate;
@property(nonatomic,strong) UITextField *txtfield;
- (IBAction)CancelView:(id)sender;


@end
