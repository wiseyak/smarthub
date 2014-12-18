//
//  Constants.h
//  HubImpact
//
//  Created by Prakash Maharjan on 15/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#ifndef HubImpact_Constants_h

#define kGOOGLE_API_KEY @"AIzaSyDCwd0F6gAeK7Xcgf4roH-fndwJdYnGY8Q"
#define CORNER_RADIUS_PRESENT_VIEW 15.0f

#define SCREEN_HEIGHT  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication  sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568)


#define APP_DEL ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define IOS7_OR_HIGHER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8_OR_HIGHER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//Tab icons image
#define NEW_FORM_ICON @"add-new-form-icon.png"
#define SUBMISSION_ICON @"submission-icon-on-menu.png"

#define X_POINT_1  435.0f
#define X_POINT_2  525.0f
#define X_POINT_3  615.0f

#define FLOOR_Y_POINT 10.0f
#define WALLS_Y_POINT 60.0f
#define WINDOWS_Y_POINT 110.0f
#define CURTAINS_Y_POINT 163.0f
#define FURNISHING_Y_POINT 215.0f

//visual comments
#define VISUAL_X_1 180.0f
#define VISUAL_X_2 245.0f
#define VISUAL_X_3 310.0f

#define VISUAL_Y_1 110.0f

#define RADIO_BUTTON_WIDTH 80.0f
#define RADIO_BUTTON_HEIGHT 44.0f

//login view switch key
#define K_SWITCH_KEY @"switch_key"

#endif
