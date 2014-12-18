//
//  InspectionCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inspectionDateTxt;
@property (weak, nonatomic) IBOutlet UITextField *inspectionTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *presentTxt;
@end
