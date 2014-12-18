//
//  DeclarationCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeclarationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *declarationDateTxt;
@property (weak, nonatomic) IBOutlet UITextView *teenantSignatureTxt;
@property (weak, nonatomic) IBOutlet UITextView *behalfTxt;

@end
