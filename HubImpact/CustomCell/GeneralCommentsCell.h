//
//  GeneralCommentsCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *generalCommmentsPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *generalCommentsTxt;

@end
