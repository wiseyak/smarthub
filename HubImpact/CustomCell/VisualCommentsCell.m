//
//  VisualCommentsCell.m
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "VisualCommentsCell.h"

@implementation VisualCommentsCell
@synthesize gutterPlaceHolderLbl,windowsPlaceHolderLbl,wallsPlaceHolderLbl,rooftilesPlaceHolderLbl,fencingPlaceHolderLbl,gatesPlaceHolderLbl,gardenPlaceHolderLbl,commAreaPlaceHolderLbl,smokeDetectorPlaceHolderLbl;
@synthesize gutterImgView,windowImgView,wallsImgView,roofTileimgView,fencingImgView,gatesImgView,gardenImgView,commAreaImgView,smokeDetectorImgView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
