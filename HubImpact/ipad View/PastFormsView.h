//
//  PastFormsView.h
//  HubImpact
//
//  Created by Prakash Maharjan on 9/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "AddNewFormVC.h"
@class RepairsCell;
@class CleanlinessCell;
@class GeneralCommentsCell;
@class FutureVisitsCell;
@class InsuranceCell;
@class DeclarationCell;
@class InspectionCell;
@class VisualCommentsCell;
@class NoteDamageCell;
@class NoteBreakageCell;
@class FinalWordsCell;
@class HeaderCell;

@interface PastFormsView : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    //visual comments
    NSMutableArray *gutterRbArray;
    NSMutableArray *windowsRbArray;
    NSMutableArray *wallsRbArray;
    NSMutableArray *roofRbArray;
    NSMutableArray *fencingRbArray;
    NSMutableArray *gatesRbArray;
    NSMutableArray *gardenRbArray;
    NSMutableArray *comAreaRbArray;
    NSMutableArray *smokeDetectorRbArray;
    
    //future visits
     NSMutableArray *futureVisitRbArray;
    //insurance
     NSMutableArray *insuranceRbArray;
    
    //final words
    NSMutableArray *finalwordsRbArray;
    NSMutableArray *finalwordsRbArray2;
    
    //cleanliness Reception1 Radio Arrays
    NSMutableArray *cl1floor1RbArray;
    NSMutableArray *cl1wall1Rb1Array;
    NSMutableArray *cl1windows1Rb1Array;
    NSMutableArray *cl1curtains1Rb1Array;
    NSMutableArray *cl1furnishing1Rb1Array;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) CleanlinessCell *cleanlinessCell;
@property(nonatomic,strong) RepairsCell *repairsCell;
@property(nonatomic,strong) GeneralCommentsCell *generalCommentsCell;
@property(nonatomic,strong) FutureVisitsCell *futureVisitCell;
@property(nonatomic,strong) InsuranceCell *insuranceCell;
@property(nonatomic,strong) DeclarationCell *declarationCell;
@property(nonatomic,strong) InspectionCell *inspectionCell;
@property(nonatomic,strong) VisualCommentsCell *commentsCell;
@property(nonatomic,strong) NoteDamageCell *noteDamageCell;
@property(nonatomic,strong) NoteBreakageCell *noteBreakageCell;
@property(nonatomic,strong) FinalWordsCell *finalCell;
@property(nonatomic,strong) HeaderCell *headerCell;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong)UITableViewCell *tempRefCell;
@property (nonatomic, assign) CGRect rect;

@property (weak, nonatomic) IBOutlet UITextField *propertyAddressTxt;
@property (weak, nonatomic) IBOutlet UITextField *prepairedByTxt;
@property(nonatomic,strong) NSMutableDictionary *mainDictionary;
@property(nonatomic,strong) NSMutableArray *mainArray;
@property(nonatomic,strong) NSMutableArray *Array;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLbl;

@property(nonatomic,strong) NSMutableArray *radioArray;
@property(nonatomic,strong) NSMutableArray *commentsRadioArray;

//visual comments radio buttons array
@property (nonatomic ,retain)NSMutableArray *gutterRbArray;
@property (nonatomic ,retain)NSMutableArray *windowsRbArray;
@property (nonatomic ,retain)NSMutableArray *wallsRbArray;
@property (nonatomic ,retain)NSMutableArray *roofRbArray;
@property (nonatomic ,retain)NSMutableArray *fencingRbArray;
@property (nonatomic ,retain)NSMutableArray *gatesRbArray;
@property (nonatomic ,retain)NSMutableArray *gardenRbArray;
@property (nonatomic ,retain)NSMutableArray *comAreaRbArray;
@property (nonatomic ,retain)NSMutableArray *smokeDetectorRbArray;

//future visists radio buttons array
@property (nonatomic ,retain)NSMutableArray *futureVisitRbArray;

//insurance radion buttons array
@property (nonatomic ,retain)NSMutableArray *insuranceRbArray;

//final words radio buttons array
@property (nonatomic ,retain)NSMutableArray *finalwordsRbArray;
@property (nonatomic ,retain)NSMutableArray *finalwordsRbArray2;

//for cleanliness cell 1
@property (nonatomic ,retain)NSMutableArray *cl1floor1RbArray;
@property (nonatomic ,retain)NSMutableArray *cl1wall1Rb1Array;
@property (nonatomic ,retain)NSMutableArray *cl1windows1Rb1Array;
@property (nonatomic ,retain)NSMutableArray *cl1curtains1Rb1Array;
@property (nonatomic ,retain)NSMutableArray *cl1furnishing1Rb1Array;



@end
