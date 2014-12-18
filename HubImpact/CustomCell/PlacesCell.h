//
//  PlacesCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 18/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PlacesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *placenamLbl;
@property (weak, nonatomic) IBOutlet UILabel *vicinityLbl;
@property (weak, nonatomic) IBOutlet UIImageView *placeIcon;
@end
