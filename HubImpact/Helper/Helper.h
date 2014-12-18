//
//  Helper.h
//  HubImpact
//
//  Created by Prakash Maharjan on 9/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"
#import "Reachability.h"

//#define FONT_ROBOTO(s) [UIFont fontWithName:@"Roboto-Regular" size:s]
#define FONT_ROBOTO_REGULAR(s) [UIFont fontWithName:@"Roboto-Regular" size:s]
#define FONT_ROBOTO(s) [UIFont fontWithName:@"Roboto-Light" size:s]

#define FONT_ROBOTO_BOLD(s) [UIFont fontWithName:@"Roboto-Bold" size:s]
#define FONT_ROBOTO_LIGHT(s) [UIFont fontWithName:@"Roboto-Light" size:s]
#define FONT_ROBOTO_MEDIUM(s) [UIFont fontWithName:@"Roboto-Medium" size:s]
#define FONT_COLOR [UIColor colorWithRed:53.0f/255.0f green:53.0f/255.0f blue:53.0f/255.0f alpha:1.0]

//#define SCREEN_HEIGHT  [[UIScreen mainScreen]bounds].size.height

#define ViewTag 101
#define trendingViewTag 105
#define GenderTag 102

#define MaleTag 10
#define FemaleTag 11

#define TransparantViewTag 1025590

@interface Helper : NSObject

+ (NSUserDefaults*)getUserDefaults;
+ (void)clearAndRemoveUserProfileDetails;

//login
+ (void)LoginUser;
+ (void)LogOutUser;
+ (BOOL)isUSerLoggedIn;
+ (NSDateFormatter*)getdateformat;
+ (MBProgressHUD*)getHudforview:(UIView*)view;

+ (void)overlapTransparantViewforview:(UIView*)view;
+ (void)removeTransparantViewForview:(UIView*)view;

//user feed
+ (void)setUserFeed:(NSMutableArray*)feedArry;
+ (NSMutableArray*)getUserFeed;

//connection
+ (BOOL)checkConnection;
+ (BOOL)isVersionLesserThan8;
+ (BOOL)isiPhone5orGreater;
+ (BOOL)isiPhone5;
+ (BOOL)isiphonelessthan4inch;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSIndexPath*)indexpathForCellImageTapped:(UIGestureRecognizer *)gestureRecognizer;
+ (NSIndexPath *) getTableViewCellIndexForInfobtnFromSubview:(UIView*)subview forTableView:(UITableView*)tableview;

//Resize and Crop Image
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize topHeight:(CGFloat)height;

@end
