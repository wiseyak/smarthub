//
//  Helper.m
//  HubImpact
//
//  Created by Prakash Maharjan on 9/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "Helper.h"

//#import "Constants.h"

@implementation Helper

+ (NSUserDefaults*)getUserDefaults
{
    static NSUserDefaults *userdefault;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userdefault=[[NSUserDefaults alloc]init];
    });
    return userdefault;
}

+ (NSString *)GetUNIQUEID
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSString *data = [delegate valueForKey:@"UUID"];
    
    if(data!=nil)
    {
        return data;
    }
    else
    {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        
        NSString *uuid = (__bridge NSString *)string;
        
        [delegate setObject:uuid forKey:@"UUID"];
        [delegate synchronize];
        
        return (__bridge NSString *)string;
    }
}

+ (void)LoginUser
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSString *data = [delegate valueForKey:@"login"];
    
    if(data==nil)
    {
        [delegate setValue:@"yes" forKey:@"login"];
    }
    else
    {
        if ([[delegate valueForKey:@"login"]isEqualToString:@"no"])
        {
             [delegate setValue:@"yes" forKey:@"login"];
        }
    }
}

+ (void)LogOutUser
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSString *data = [delegate valueForKey:@"login"];
    
    if(data==nil)
    {
        [delegate setValue:@"no" forKey:@"login"];
    }
    else
    {
        if ([[delegate valueForKey:@"login"]isEqualToString:@"yes"])
        {
            [delegate setValue:@"no" forKey:@"login"];
        }
    }
}

+ (BOOL)isUSerLoggedIn
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSString *data = [delegate valueForKey:@"login"];
    
    if(data==nil)
    {
        return NO;
    }
    else
    {
        if ([[delegate valueForKey:@"login"]isEqualToString:@"no"])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}


+ (void)setUserFeed:(NSMutableArray*)feedArry
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:feedArry];
    [delegate setObject:newData forKey:@"USERFEED"];
    [delegate synchronize];

}

+ (NSMutableArray*)getUserFeed
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    NSData *data=[delegate objectForKey:@"USERFEED"];
    if (data!=nil)
    {
        NSLog(@"size and data %@",[(NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy]);
        return [(NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
    }
    return nil;
}

+ (void)clearAndRemoveUserProfileDetails
{
    NSUserDefaults *delegate = [NSUserDefaults standardUserDefaults];
    [delegate setObject:nil forKey:@"USERPROFILEDETAIL"];
}

+ (NSDateFormatter*)getdateformat
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return formatter;
}

+ (MBProgressHUD*)getHudforview:(UIView*)view
{
    static MBProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud=[[MBProgressHUD alloc]initWithView:view];
       // hud.color=[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0]
        //hud.color=[UIColor blackColor];
        hud.color=[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:0.8f];
        hud.mode = MBProgressHUDModeIndeterminate;
        [view bringSubviewToFront:hud];
    });
    return hud;
}

//check connection
+ (BOOL)checkConnection
{
    int status=0;
    Reachability *hostReach = [Reachability reachabilityWithHostname: @"www.google.com"] ;
    //[hostReach startNotifier];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            status= 0;
            return NO;
            break;
        }
        case ReachableViaWiFi:
        {
            status= 1;
            return YES;
            break;
        }
        case ReachableViaWWAN:
        {
            status= 2;
            return YES;
            break;
        }
    }
}
/*
//show transparant view
+ (void)overlapTransparantViewforview:(UIView*)view
{
    UIView *transparantview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    transparantview.backgroundColor=[UIColor lightGrayColor];
    transparantview.alpha=1.0;
    transparantview.tag=TransparantViewTag;
    [view addSubview:transparantview];
}
*/
+ (void)removeTransparantViewForview:(UIView*)view
{
    UIView *transparantview=(UIView*)[view viewWithTag:TransparantViewTag];
    [transparantview removeFromSuperview];
}


#pragma mark --get cell index
+(NSIndexPath *) getTableViewCellIndexForInfobtnFromSubview:(UIView*)subview forTableView:(UITableView*)tableview
{
    UITableViewCell* tableviewcell = nil;
    
    while (subview.superview != Nil){
        if ([subview.superview isKindOfClass:[UITableViewCell class]])
        {
            tableviewcell = (UITableViewCell*)subview.superview;
            break;
        }
        else
        {
            subview = subview.superview;
        }
    }
    NSIndexPath *indexpath=[tableview indexPathForCell:tableviewcell];
    return indexpath;
}

+ (NSIndexPath*)indexpathForCellImageTapped:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *parentCell = gestureRecognizer.view.superview;
    
    while (![parentCell isKindOfClass:[UITableViewCell class]]) {   // iOS 7 onwards the table cell hierachy has changed.
        parentCell = parentCell.superview;
    }
    
    UIView *parentView = parentCell.superview;
    
    while (![parentView isKindOfClass:[UITableView class]]) {   // iOS 7 onwards the table cell hierachy has changed.
        parentView = parentView.superview;
    }
    
    
    UITableView *tableView = (UITableView *)parentView;
    NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell *)parentCell];
    
    NSLog(@"indexPath = %@", indexPath);
    return indexPath;
}

+ (BOOL)isVersionLesserThan8
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 8.0)
    {
        return YES;
    }
    else
    {
        return  NO;
    }
}

+ (BOOL)isiPhone5orGreater
{
    int screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f)
    {
        return  YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL)isiPhone5
{
    if([[UIScreen mainScreen] bounds].size.height == 568.0f)

    {
        return  YES;
    }
    else
    {
        return NO;
    }
}
+ (BOOL)isiphonelessthan4inch{
    if([[UIScreen mainScreen] bounds].size.height == 480.0f)
        
    {
        return  YES;
    }
    else
    {
        return NO;
    }
    
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    //color=[UIColor lightGrayColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
