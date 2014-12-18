//
//  UIViewController+ModalViewDismissOnOutsideTap.h
//  HubImpact
//
//  Created by Prakash Maharjan on 15/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ModalViewDismissOnOutsideTap) <UIGestureRecognizerDelegate>
- (void)registerForDismissOnTapOutside; // Call in viewDidAppear
- (void)unregisterForDismissOnTapOutside; // Call in viewWillDisappear
@end
