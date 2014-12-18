//
//  AddNewFormVC.h
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompleteViewController.h"
#import "LocationSuggestionView.h"
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

@class RadioButton;

@class AFHTTPRequestOperation;
@class CLCloudinary;
@class CLUploader;
@class ASIHTTPRequest;

#import "JSON.h"
#import "SBJSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@interface AddNewFormVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIToolbarDelegate,UIScrollViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,SecondDelegate>
{
    NSMutableArray *futureVisitRbArray;
    NSMutableArray *finalwordsRbArray;
    NSMutableArray *finalwordsRbArray2;
    NSMutableArray *insuranceRbArray;
    NSMutableArray *gutterRbArray;
    NSMutableArray *windowsRbArray;
    NSMutableArray *wallsRbArray;
    NSMutableArray *roofRbArray;
    NSMutableArray *fencingRbArray;
    NSMutableArray *gatesRbArray;
    NSMutableArray *gardenRbArray;
    NSMutableArray *comAreaRbArray;
    NSMutableArray *smokeDetectorRbArray;
    NSMutableArray *cl1floor1RbArray;
    NSMutableArray *cl1wall1Rb1Array;
    NSMutableArray *cl1windows1Rb1Array;
    NSMutableArray *cl1curtains1Rb1Array;
    NSMutableArray *cl1furnishing1Rb1Array;
    
    NSMutableArray *cl2floor2RbArray;
    NSMutableArray *cl2wall2RbArray;
    NSMutableArray *cl2windows2RbArray;
    NSMutableArray *cl2curtains2RbArray;
    NSMutableArray *cl2furnishing2RbArray;
    
    NSMutableArray *cl3floor3RbArray;
    NSMutableArray *cl3wall3RbArray;
    NSMutableArray *cl3windows3RbArray;
    NSMutableArray *cl3curtains3RbArray;
    NSMutableArray *cl3furnishing3RbArray;
    
    NSMutableArray *cl4floor4RbArray;
    NSMutableArray *cl4wall4RbArray;
    NSMutableArray *cl4windows3RbArray;
    NSMutableArray *cl4curtains4RbArray;
    NSMutableArray *cl4furnishing4RbArray;
    
    NSMutableArray *cl5floor5RbArray;
    NSMutableArray *cl5wall5RbArray;
    NSMutableArray *cl5windows5RbArray;
    NSMutableArray *cl5curtains5RbArray;
    NSMutableArray *cl5furnishing5RbArray;
    
    NSMutableArray *cl6floor6RbArray;
    NSMutableArray *cl6wall6RbArray;
    NSMutableArray *cl6windows6RbArray;
    NSMutableArray *cl6curtains6RbArray;
    NSMutableArray *cl6furnishing6RbArray;
    
    NSMutableArray *cl7floor7RbArray;
    NSMutableArray *cl7wall7RbArray;
    NSMutableArray *cl7windows7RbArray;
    NSMutableArray *cl7curtains7RbArray;
    NSMutableArray *cl7furnishing7RbArray;
    
    
    NSMutableArray *cl8floor8RbArray;
    NSMutableArray *cl8wall8RbArray;
    NSMutableArray *cl8windows8RbArray;
    NSMutableArray *cl8curtains8RbArray;
    NSMutableArray *cl8furnishing8RbArray;
    
    BOOL firstBtnCliked,cameraOpen,secondBtnCliked,thirdBtnCliked,fourthBtnCliked,firstImgINDict,secondImgINDict,thirdImgINDict,fourthImgINDict;
    int tagNo;
    BOOL gutterBtnClicked,windowsBtnClicked,wallsBtnCliked,roofTileBtnCliked,fencingBtnClicked,gatesBtnClicked,gardenBtnClicked,commAreaBtnClicked,smokeDetectorBtnClicked;
}
@property (nonatomic ,retain)NSMutableArray *futureVisitRbArray;
@property (nonatomic ,retain)NSMutableArray *finalwordsRbArray;
@property (nonatomic ,retain)NSMutableArray *finalwordsRbArray2;
@property (nonatomic ,retain)NSMutableArray *insuranceRbArray;
@property (nonatomic ,retain)NSMutableArray *gutterRbArray;
@property (nonatomic ,retain)NSMutableArray *windowsRbArray;
@property (nonatomic ,retain)NSMutableArray *wallsRbArray;
@property (nonatomic ,retain)NSMutableArray *roofRbArray;
@property (nonatomic ,retain)NSMutableArray *fencingRbArray;
@property (nonatomic ,retain)NSMutableArray *gatesRbArray;
@property (nonatomic ,retain)NSMutableArray *gardenRbArray;
@property (nonatomic ,retain)NSMutableArray *comAreaRbArray;
@property (nonatomic ,retain)NSMutableArray *smokeDetectorRbArray;

//for cleanliness cell 1
@property (nonatomic ,retain)NSMutableArray *cl1floor1RbArray;
@property (nonatomic ,retain)NSMutableArray *cl1wall1Rb1Array;
@property (nonatomic ,retain)NSMutableArray *cl1windows1Rb1Array;
 @property (nonatomic ,retain)NSMutableArray *cl1curtains1Rb1Array;
@property (nonatomic ,retain)NSMutableArray *cl1furnishing1Rb1Array;


//for cleanliness cell 2
@property (nonatomic ,retain)NSMutableArray *cl2floor2RbArray;
@property (nonatomic ,retain)NSMutableArray *cl2wall2RbArray;
@property (nonatomic ,retain)NSMutableArray *cl2windows2RbArray;
@property (nonatomic ,retain)NSMutableArray *cl2curtains2RbArray;
@property (nonatomic ,retain)NSMutableArray *cl2furnishing2RbArray;

//for cleanliness cell 3
@property (nonatomic ,retain)NSMutableArray *cl3floor3RbArray;
@property (nonatomic ,retain)NSMutableArray *cl3wall3RbArray;
@property (nonatomic ,retain)NSMutableArray *cl3windows3RbArray;
@property (nonatomic ,retain)NSMutableArray *cl3curtains3RbArray;
@property (nonatomic ,retain)NSMutableArray *cl3furnishing3RbArray;


//for cleanliness cell 4
@property (nonatomic ,retain)NSMutableArray *cl4floor4RbArray;
@property (nonatomic ,retain)NSMutableArray *cl4wall4RbArray;
@property (nonatomic ,retain)NSMutableArray *cl4windows4RbArray;
@property (nonatomic ,retain)NSMutableArray *cl4curtains4RbArray;
@property (nonatomic ,retain)NSMutableArray *cl4furnishing4RbArray;

//for cleanliness cell 5
@property (nonatomic ,retain)NSMutableArray *cl5floor5RbArray;
@property (nonatomic ,retain)NSMutableArray *cl5wall5RbArray;
@property (nonatomic ,retain)NSMutableArray *cl5windows5RbArray;
@property (nonatomic ,retain)NSMutableArray *cl5curtains5RbArray;
@property (nonatomic ,retain)NSMutableArray *cl5furnishing5RbArray;


//for cleanliness cell 6
@property (nonatomic ,retain)NSMutableArray *cl6floor6RbArray;
@property (nonatomic ,retain)NSMutableArray *cl6wall6RbArray;
@property (nonatomic ,retain)NSMutableArray *cl6windows6RbArray;
@property (nonatomic ,retain)NSMutableArray *cl6curtains6RbArray;
@property (nonatomic ,retain)NSMutableArray *cl6furnishing6RbArray;

//for cleanliness cell 7
@property (nonatomic ,retain)NSMutableArray *cl7floor7RbArray;
@property (nonatomic ,retain)NSMutableArray *cl7wall7RbArray;
@property (nonatomic ,retain)NSMutableArray *cl7windows7RbArray;
@property (nonatomic ,retain)NSMutableArray *cl7curtains7RbArray;
@property (nonatomic ,retain)NSMutableArray *cl7furnishing7RbArray;

//for cleanliness cell 8
@property (nonatomic ,retain)NSMutableArray *cl8floor8RbArray;
@property (nonatomic ,retain)NSMutableArray *cl8wall8RbArray;
@property (nonatomic ,retain)NSMutableArray *cl8windows8RbArray;
@property (nonatomic ,retain)NSMutableArray *cl8curtains8RbArray;
@property (nonatomic ,retain)NSMutableArray *cl8furnishing8RbArray;


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
@property(nonatomic,assign)  int currentExpandedIndex;
@property(nonatomic,strong) NSMutableArray *titleArray;



@property(nonatomic,strong) UIDatePicker *datepickerView;
@property(nonatomic,strong) UIToolbar *toolbar;
@property(nonatomic,strong)UIToolbar *normalkeyboardtoolbar;

@property(nonatomic,strong) NSMutableArray *radioArray;
@property(nonatomic,strong) NSMutableArray *commentsRadioArray;
//future visit cell radio button
@property (nonatomic, strong) IBOutlet RadioButton *futureVisitradioButton;



//- (IBAction)futureRadioBtn:(id)sender;


//final words cell radio button
@property (nonatomic, strong) IBOutlet RadioButton *finalwordsradioButton;
@property (nonatomic, strong) IBOutlet RadioButton *finalwordsradioButton2;
@property (weak, nonatomic) IBOutlet UITextField *propertyAddressTxt;
@property (weak, nonatomic) IBOutlet UITextField *prepairedByTxt;
@property (nonatomic, assign) CGRect rect;
@property(nonatomic,strong)UITableViewCell *tempRefCell;

//Insurance cell radio button
@property (nonatomic, strong) IBOutlet RadioButton *insuranceradioButton;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitReport:(id)sender;

@property(nonatomic,strong) AFHTTPRequestOperation *submitRequest;
@property(nonatomic,strong) ASIFormDataRequest *submitpostrequest;
@property(nonatomic,strong) UIImage *r1img1;
@property(nonatomic,strong) UIImage *r1img2;
@property(nonatomic,strong) UIImage *r1img3;
@property(nonatomic,strong) NSString *r1img1URL;
@property(nonatomic,strong) NSString *r1img2URL;
@property(nonatomic,strong) NSString *r1img3URL;
@property(nonatomic,strong)UITextField *txtFieldForRoomDropDown;
@property(nonatomic,strong) NSString *trackSelectedRadioButton;

- (IBAction)cloudTest:(id)sender;
//final words
@property(nonatomic,strong)NSString *isdeterioated;
@property(nonatomic,strong)NSString *isgoodCondition;

//visual commments value
@property(nonatomic,strong) NSString *gutterValue;
@property(nonatomic,strong) NSString *windowsValue;
@property(nonatomic,strong) NSString *wallsValue;
@property(nonatomic,strong) NSString *roofTileValue;
@property(nonatomic,strong) NSString *fencingValue;
@property(nonatomic,strong) NSString *gatesValue;
@property(nonatomic,strong) NSString *gardenValue;
@property(nonatomic,strong) NSString *commAreaValue;
@property(nonatomic,strong) NSString *smokeDetectorValue;

//insurance value
@property(nonatomic,strong) NSString *isinsuranceValue;
//future visit
@property(nonatomic,strong) NSString *isfuturevisitValue;

//cleanliness value
@property(nonatomic,strong) NSString *floor1Value;
@property(nonatomic,strong) NSString *walls1Value;
@property(nonatomic,strong) NSString *windows1Value;
@property(nonatomic,strong) NSString *curtains1Value;
@property(nonatomic,strong) NSString *furnishing1Value;

@property(nonatomic,strong) CLCloudinary *cloudinary1;
@property(nonatomic,strong) CLUploader *uploader1;
@property(nonatomic,strong) CLCloudinary *cloudinary2;
@property(nonatomic,strong) CLUploader *uploader2;
@property(nonatomic,strong) CLCloudinary *cloudinary3;
@property(nonatomic,strong) CLUploader *uploader3;

@property(nonatomic,strong) NSString *propertyAddTxt;
@property(nonatomic,strong) NSString *prepairedTxt;
@property(nonatomic,strong) NSString *outstandingRepairTxt;
@property(nonatomic,strong) NSString *GeneralCommentTxt;
@property(nonatomic,strong) NSString *FutureVisitDateTxt;
@property(nonatomic,strong) NSString *InsurancePolicyNoTxt;
@property(nonatomic,strong) NSString *InsuranceDetailTxt;

@property(nonatomic,strong) NSString *TenanatSignatureTxt;
@property(nonatomic,strong) NSString *OnTheBehalfOfTxt;
@property(nonatomic,strong) NSString *DeclarationDateTxt;

@property(nonatomic,strong) NSString *InspectionDateTxt;
@property(nonatomic,strong) NSString *InspectionTimeTxt;
@property(nonatomic,strong) NSString *InspectionPresentTxt;

@property(nonatomic,strong) NSString *GutterCommentTxt;
@property(nonatomic,strong) NSString *WindowCommentTxt;
@property(nonatomic,strong) NSString *WallCommentTxt;
@property(nonatomic,strong) NSString *RoofTileCommentTxt;
@property(nonatomic,strong) NSString *FencingCommentTxt;
@property(nonatomic,strong) NSString *GatesCommentTxt;
@property(nonatomic,strong) NSString *GardenCommentTxt;
@property(nonatomic,strong) NSString *CommentAreaTxt;
@property(nonatomic, strong) NSString *SmokeDetectorTxt;

@property(nonatomic,strong) NSString *damageCommentTxt;
@property(nonatomic,strong) NSString *breakageAreaTxt;

@property(nonatomic,strong) NSString *string;
@property (nonatomic) BOOL isfirst;
@property (nonatomic) BOOL issecond;
@property (nonatomic) BOOL isthird;
@property(nonatomic,strong)AddNewFormVC *views;

@property (assign) int visualTag;

@property(nonatomic,strong) IBOutlet UIPickerView *loggedInUserpickerVC;
@property(nonatomic,strong) NSMutableArray *userArray;
@property(nonatomic,strong) NSArray *RoomTypeArray;

@property(nonatomic,strong) NSMutableDictionary *userdict;
@property(nonatomic,strong) NSString *loggedInUser;
@property(nonatomic,strong) NSString *tokenValue;
@property(nonatomic,strong) ASIHTTPRequest *userlistRequest;
@property (weak, nonatomic) IBOutlet UIView *baseView;
- (IBAction)clearnLinesBtnTapped:(id)sender;
- (IBAction)cleanBtnTap:(id)sender;


- (IBAction)getAddress:(id)sender;

@end
