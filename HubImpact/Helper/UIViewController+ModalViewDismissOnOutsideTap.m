//
//  UIViewController+ModalViewDismissOnOutsideTap.m
//  HubImpact
//
//  Created by Prakash Maharjan on 15/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "UIViewController+ModalViewDismissOnOutsideTap.h"
#import <objc/runtime.h>

static char gestureRecognizerKey;

@implementation UIViewController (ModalViewDismissOnOutsideTap)

- (void)setGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    objc_setAssociatedObject(self, &gestureRecognizerKey, gestureRecognizer, OBJC_ASSOCIATION_ASSIGN);
}

- (UIGestureRecognizer *)gestureRecognizer
{
    return objc_getAssociatedObject(self, &gestureRecognizerKey);
}

- (void)handleDismissTap:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
            // Passing nil gives us coordinates in the window
        CGPoint location = [gesture locationInView:nil];
        
            // Then we convert the tap's location into the local view's coordinate system
        location = [self.view convertPoint:location fromView:self.view.window];
        
        if (![self.view pointInside:location withEvent:nil])
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)registerForDismissOnTapOutside
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissTap:)];
    recognizer.numberOfTapsRequired = 1;
        // So the user can still interact with controls in the modal view
    recognizer.cancelsTouchesInView = NO;
    
    self.gestureRecognizer = recognizer;
    self.gestureRecognizer.delegate = self;
    [self.view.window addGestureRecognizer:recognizer];
}

- (void)unregisterForDismissOnTapOutside
{
    [self.view.window removeGestureRecognizer:self.gestureRecognizer];
    self.gestureRecognizer = nil;
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
@end
