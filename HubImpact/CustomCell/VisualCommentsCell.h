//
//  VisualCommentsCell.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisualCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *gutterTxt;
@property (weak, nonatomic) IBOutlet UITextView *windowTxt;
@property (weak, nonatomic) IBOutlet UITextView *wallTxt;
@property (weak, nonatomic) IBOutlet UITextView *roofTileTxt;
@property (weak, nonatomic) IBOutlet UITextView *fencingTxt;
@property (weak, nonatomic) IBOutlet UITextView *gatesTxt;
@property (weak, nonatomic) IBOutlet UITextView *gardenTxt;
@property (weak, nonatomic) IBOutlet UITextView *commAreaTxt;
@property (weak, nonatomic) IBOutlet UITextView *smokeDetectorTxt;
@property (weak, nonatomic) IBOutlet UILabel *gutterPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *windowsPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *wallsPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *rooftilesPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *fencingPlaceHolderLbl;

@property (weak, nonatomic) IBOutlet UILabel *gatesPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *gardenPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *commAreaPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UILabel *smokeDetectorPlaceHolderLbl;
@property (weak, nonatomic) IBOutlet UIButton *gutterImgView;
@property (weak, nonatomic) IBOutlet UIButton *windowImgView;
@property (weak, nonatomic) IBOutlet UIButton *wallsImgView;
@property (weak, nonatomic) IBOutlet UIButton *roofTileimgView;
@property (weak, nonatomic) IBOutlet UIButton *fencingImgView;
@property (weak, nonatomic) IBOutlet UIButton *gatesImgView;

@property (weak, nonatomic) IBOutlet UIButton *gardenImgView;
@property (weak, nonatomic) IBOutlet UIButton *commAreaImgView;
@property (weak, nonatomic) IBOutlet UIButton *smokeDetectorImgView;

@end
