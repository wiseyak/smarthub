//
//  AppDelegate.m
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginView.h"
#import "PreviewPastFormView.h"
#import "AddNewFormVC.h"
#import "Constants.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize loginVC,addnewformVC,previewpastformVC,tab;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    tab=[[UITabBarController alloc]init];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    addnewformVC=[[AddNewFormVC alloc]initWithNibName:@"AddNewFormVC" bundle:nil];

    previewpastformVC=[[PreviewPastFormView alloc] initWithNibName:@"PreviewPastFormView" bundle:nil];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"TrebuchetMS-Bold" size:13.0f],
                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"TrebuchetMS-Bold" size:13.0f],
                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateSelected];
    
    [[UITabBar appearance] setItemWidth:self.window.frame.size.width/2];

    UINavigationController *addnewformVCnav=[[UINavigationController alloc]initWithRootViewController:addnewformVC];

    UINavigationController *previewpastformVCnav=[[UINavigationController alloc]initWithRootViewController:previewpastformVC];

    
    UIImage *addnewformSelected = [UIImage imageNamed:NEW_FORM_ICON];
    UIImage *addnewformUnSelected = [UIImage imageNamed:NEW_FORM_ICON];
    
    UIImage *submissionSelected = [UIImage imageNamed:SUBMISSION_ICON];
    UIImage *submissionUnSelected = [UIImage imageNamed:SUBMISSION_ICON];
    
    [addnewformVCnav.tabBarItem setImage:[addnewformUnSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [addnewformVCnav.tabBarItem setSelectedImage:[addnewformSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [previewpastformVCnav.tabBarItem setImage:[submissionUnSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [previewpastformVCnav.tabBarItem setSelectedImage:[submissionSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [addnewformVCnav.tabBarItem setTitle:@"ADD NEW FORM"];
    [previewpastformVCnav.tabBarItem setTitle:@"SUBMISSIONS"];
    [addnewformVCnav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [previewpastformVCnav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [tab setViewControllers:[NSArray arrayWithObjects:addnewformVCnav,previewpastformVCnav,nil]];
    //color
    [[UITabBar appearance]setBarTintColor:[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
    [[UITabBar appearance]setBackgroundColor:[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
    [tab setSelectedIndex:1];
    tab.tabBar.translucent=NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    loginVC = [[LoginView alloc]initWithNibName:@"LoginView" bundle:nil];
    [self.window setRootViewController:loginVC];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)createLoginView{
    self.window.rootViewController=loginVC;
}
-(void)createTabbar{
    self.window.rootViewController=tab;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    /*
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:@"SelectImage.png"])forKey:@"img1"];
     [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:@"SelectImage.png"])forKey:@"img2"];
     [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:@"SelectImage.png"])forKey:@"img3"];
    */
}

@end
