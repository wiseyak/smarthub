//
//  AppDelegate.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define APP_DEL ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@class LoginView;
@class AddNewFormVC;
@class PreviewPastFormView;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) LoginView *loginVC;
@property(strong,nonatomic) AddNewFormVC *addnewformVC;
@property(strong,nonatomic) PreviewPastFormView *previewpastformVC;
@property (nonatomic, strong) UIPopoverController * popUp;
@property(nonatomic,strong) IBOutlet UITabBarController *tab;
-(void)createTabbar;
-(void)createLoginView;
@end


