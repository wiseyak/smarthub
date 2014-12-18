//
//  iPadActionSheet.h
//  HubImpact
//
//  Created by Prakash Maharjan on 17/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol sharedDelegate <NSObject>

-(void) promptToShareOfType:(int) tag;

@end

@interface iPadActionSheet : UIViewController
@property (nonatomic, weak) id<sharedDelegate> delegate;
- (IBAction)promptToShare:(id)sender;


@end
