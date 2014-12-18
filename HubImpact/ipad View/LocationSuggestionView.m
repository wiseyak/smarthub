//
//  LocationSuggestionView.m
//  HubImpact
//
//  Created by Prakash Maharjan on 18/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//


#import "LocationSuggestionView.h"
#import "PlacesCell.h"
#import "UIViewController+ModalViewDismissOnOutsideTap.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
@interface LocationSuggestionView ()

@end

@implementation LocationSuggestionView
@synthesize locationsArray;
@synthesize placesCell;
@synthesize getplacesRequest;
@synthesize placename,placeVicinity,placeIconURL;
@synthesize myDelegate;
@synthesize txtfield;
@synthesize userlongitude,userlattitude;
@synthesize locationManager;
@synthesize currentLocation;
@synthesize activityIndicator;

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    // if (IS_IPAD) {
    self.view.superview.bounds = CGRectMake(0, 0, 400, 480);
    self.view.superview.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT/2));
    //}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    // Do any additional setup after loading the view from its nib.

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
       if (IOS8_OR_HIGHER)
            {
                  // [locationManager requestAlwaysAuthorization];
                [locationManager requestWhenInUseAuthorization];
                 [locationManager startUpdatingLocation];
        
            }

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
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Could not track Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        // longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"long::%f",currentLocation.coordinate.longitude);
        NSLog(@"lat::%f",currentLocation.coordinate.latitude);
    }
    [locationManager stopUpdatingLocation];
    
    if (![getplacesRequest isExecuting]) {
        [self getplaces];
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
    [super viewWillDisappear:YES];
    if ([getplacesRequest isExecuting]) {
        [getplacesRequest cancel];
    }
    // if (IS_IPAD) {
    if (self.presentingViewController) {
        [self unregisterForDismissOnTapOutside];
        // }
    }
    
    [self.searchDisplayController.searchBar resignFirstResponder];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return locationsArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PlacesCell";
    [placesCell setSelectionStyle:UITableViewCellSelectionStyleGray]; //for
    placesCell = (PlacesCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.placesCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlacesCell" owner:self options:nil];
        self.placesCell = [nib objectAtIndex:0];
    }
    if (!locationsArray.count==0)
    {
        NSDictionary *dict=[locationsArray objectAtIndex:indexPath.row];
        self.placesCell.placenamLbl.text=[dict valueForKey:@"name"];
        self.placesCell.vicinityLbl.text=[dict valueForKey:@"vicinity"];
        
         [self.placesCell.placeIcon sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@""]];
    }
   
    return placesCell;
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSString *place = [self placeAtIndexPath:indexPath].name;

  
    if (!locationsArray.count==0)
    {
        NSDictionary *dict=[locationsArray objectAtIndex:indexPath.row];
        self.placesCell.placenamLbl.text=[dict valueForKey:@"name"];
    }
    
    
    [self.myDelegate secondViewControllerDismissed:self.placesCell.placenamLbl.text forTxtfld:txtfield];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


-(void)getplaces
{
    
    //https://maps.googleapis.com/maps/api/place/autocomplete/output?parameters
    //  https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@
    
    
    // NSString *URL=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&types=geocode&language=fr&key=AIzaSyDCwd0F6gAeK7Xcgf4roH-fndwJdYnGY8Q"];
    
   // NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=27.732059400000000000,85.307805299999930000&radius=200&key=%@",kGOOGLE_API_KEY];
    
    NSLog(@"longggggg::%f",currentLocation.coordinate.longitude);
    NSLog(@"latttttt::%f",currentLocation.coordinate.latitude);
    //NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=200&key=%@",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude,kGOOGLE_API_KEY];
    
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&sensor=true&key=%@",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,[NSString stringWithFormat:@"%i", 200], kGOOGLE_API_KEY];

    
    // NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=27.7,85.3333&radius=%@&types=atm|food&sensor=true&key=%@",[NSString stringWithFormat:@"%i", 1000], kGOOGLE_API_KEY];
    
    NSString *fixedURL = [URL
                          stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    getplacesRequest = [ASIFormDataRequest requestWithURL:url];
    
    [getplacesRequest setRequestMethod:@"GET"];
    
    //[postrequest setPostValue:@"sample msg txt" forKey:@"message"];
    [getplacesRequest setDelegate:self];
    [getplacesRequest startAsynchronous];
    
    
}


-(void)requestStarted:(ASIHTTPRequest *)request{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    NSString *responseString = [request responseString];
    
    
    NSLog(@"*****response::::::::::%@",responseString);
    NSMutableDictionary *jsonDict=[responseString JSONValue];
            locationsArray=[jsonDict objectForKey:@"results"];
        
        if (!locationsArray.count==0) {
            for (int i=0; i<locationsArray.count; i++)
            {
                NSDictionary *dict=[locationsArray objectAtIndex:i];
                // NSLog(@"dict:::%@",dict);
                placename=[dict valueForKey:@"name"];
                NSLog(@"placename:%@",placename);
                placeVicinity=[dict valueForKey:@"vicinity"];
                placeIconURL=[dict valueForKey:@"icon"];
            }
            
            [self.tableView reloadData];

    }
   
    
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error;
    
    NSLog(@"error:%@",error.localizedDescription);
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    
    
}

@end
