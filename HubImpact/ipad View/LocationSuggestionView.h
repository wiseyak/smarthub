//
//  LocationSuggestionView.h
//  HubImpact
//
//  Created by Prakash Maharjan on 18/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JSON.h"
#import "SBJSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <CoreLocation/CoreLocation.h>
@class PlacesCell;

@protocol SecondDelegate <NSObject>

-(void) secondViewControllerDismissed:(NSString *)stringForFirst forTxtfld:(UITextField *)txt;
@end

@interface LocationSuggestionView : UIViewController<ASIHTTPRequestDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
     CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *locationsArray;
@property(nonatomic,strong) PlacesCell *placesCell;
@property(nonatomic,strong) ASIFormDataRequest *getplacesRequest;
@property(nonatomic,strong) NSString *placename;
@property(nonatomic,strong) NSString *placeVicinity;
@property(nonatomic,strong) NSString *placeIconURL;
@property (nonatomic, assign) id<SecondDelegate>myDelegate;
@property(nonatomic,strong) UITextField *txtfield;
@property(nonatomic,assign)float *userlongitude;
@property(nonatomic,assign)float *userlattitude;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,strong) CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
