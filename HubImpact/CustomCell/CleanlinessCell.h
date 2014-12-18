//
//  CleanlinessCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c)2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanlinessCell : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;

@property (weak, nonatomic) IBOutlet UIButton *Reception1Img1;
@property (weak, nonatomic) IBOutlet UIButton *Reception1Img2;
@property (weak, nonatomic) IBOutlet UIButton *Reception1Img3;
@property (weak, nonatomic) IBOutlet UITextField *reception1txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception2txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception3txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception4txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception5txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception6txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception7txtField;
@property (weak, nonatomic) IBOutlet UITextField *reception8txtField;

@end
