//
//  AddNewFormVC.m
//  HubImpact
//
//  Created by Prakash Maharjan on 23/09/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//
#import "Constants.h"
#import "LocationSuggestionView.h"
#import "AddNewFormVC.h"
#import "CleanlinessCell.h"
#import "RepairsCell.h"
#import "GeneralCommentsCell.h"
#import "FutureVisitsCell.h"
#import "InsuranceCell.h"
#import "DeclarationCell.h"
#import "InspectionCell.h"
#import "VisualCommentsCell.h"
#import "NoteDamageCell.h"
#import "NoteBreakageCell.h"
#import "FinalWordsCell.h"
#import "HeaderCell.h"

#import "RadioButton.h"
#import <QuartzCore/QuartzCore.h>

#import "AFNetworking.h"

#import "CLCloudinary.h"
#import "CLUploader.h"
#import "UIViewController+ModalViewDismissOnOutsideTap.h"

#define CLOUD_API_SECRET @"ax13AJ8tIZ3Z2yL2GjjXx_APTcE"
#define CLOUD_API_KEY @"917845251565494"
#define CLOUD_NAME @"dym11jnwp"
//#define CLOUD_URL @"cloudinary://%@:%@@%@",CLOUD_API_KEY,CLOUD_API_SECRET,CLOUD_NAME

#define CLOUD_URL @"cloudinary://917845251565494:ax13AJ8tIZ3Z2yL2GjjXx_APTcE@dym11jnwp"



#import "cleanVC.h"
//#define CLOUD_URL

//CLCloudinary *cloudinary = [[CLCloudinary alloc] initWithUrl: @"cloudinary://917845251565494:ax13AJ8tIZ3Z2yL2GjjXx_APTcE@dym11jnwp"];


@interface AddNewFormVC ()<CLUploaderDelegate>


@property (strong, nonatomic) NSArray* listOfLabels;
@property (strong, nonatomic) NSArray* imagesButtons;
@property (strong, nonatomic) UIView* cleanlinessBlock;
@property (strong, nonatomic) UIScrollView* cleanlinessScrollView;
@property(strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic) UIButton* tappedCleanlinessButton;
@property(strong,nonatomic)    UIPickerView *typeOfRoom;

@property  float ini_viewXposition;
@property int page;

@property (strong, nonatomic) NSMutableArray* radioButtons;

@property int activeCleanlinessPage;

@property BOOL cleanlinessImageUploadInProgress;
@property (strong, nonatomic) NSMutableArray* cleanlinessImagesURL;


@property (strong, nonatomic) __block CLCloudinary *cloudinary;
@property (strong, nonatomic) __block CLUploader* cloudinaryUploader;

@property (readonly) BOOL isCleanlinessCapturersLocked;


@property (weak, nonatomic) UITextField* activeRoomTypeTextField;

@end

@implementation AddNewFormVC
@synthesize string,pageControl;
@synthesize cloudinary1,cloudinary2,cloudinary3;
@synthesize uploader1,uploader2,uploader3;
@synthesize isfirst,issecond,isthird;
@synthesize views;
@synthesize visualTag;
@synthesize typeOfRoom;
@synthesize outstandingRepairTxt,GeneralCommentTxt,FutureVisitDateTxt,InsurancePolicyNoTxt,InsuranceDetailTxt,TenanatSignatureTxt,OnTheBehalfOfTxt,DeclarationDateTxt,InspectionDateTxt,InspectionTimeTxt,InspectionPresentTxt,GutterCommentTxt,WindowCommentTxt,WallCommentTxt,RoofTileCommentTxt,FencingCommentTxt,GatesCommentTxt,GardenCommentTxt,CommentAreaTxt,SmokeDetectorTxt,damageCommentTxt,breakageAreaTxt;
@synthesize loggedInUserpickerVC;
//cleanliness
@synthesize floor1Value,walls1Value,windows1Value,curtains1Value,furnishing1Value;
//final words
@synthesize isdeterioated,isgoodCondition;
//visual commemts
@synthesize gutterValue,windowsValue,wallsValue,roofTileValue,fencingValue,gatesValue,gardenValue,commAreaValue,smokeDetectorValue;
//insurance
@synthesize isinsuranceValue;
//futur visit value
@synthesize isfuturevisitValue;
@synthesize r1img1,r1img2,r1img3;
@synthesize r1img1URL,r1img2URL,r1img3URL;
@synthesize cleanlinessCell,repairsCell,generalCommentsCell,futureVisitCell,insuranceCell,declarationCell,inspectionCell,commentsCell,noteDamageCell,noteBreakageCell,finalCell,headerCell;
@synthesize currentExpandedIndex;
@synthesize titleArray;
@synthesize datepickerView;
@synthesize toolbar;
@synthesize normalkeyboardtoolbar;
@synthesize submitpostrequest;
@synthesize RoomTypeArray;
//radion buttons
@synthesize  futureVisitradioButton;
@synthesize finalwordsradioButton;
@synthesize finalwordsradioButton2;
@synthesize insuranceradioButton;
// radio arrays for buttons
@synthesize radioArray;
@synthesize commentsRadioArray;

// radio arrays for cells
@synthesize futureVisitRbArray;
@synthesize finalwordsRbArray;
@synthesize finalwordsRbArray2;
@synthesize rect;
@synthesize tempRefCell;
@synthesize insuranceRbArray;
@synthesize gutterRbArray;
@synthesize windowsRbArray;
@synthesize wallsRbArray;
@synthesize roofRbArray;
@synthesize fencingRbArray;
@synthesize gatesRbArray;
@synthesize gardenRbArray;
@synthesize comAreaRbArray;
@synthesize smokeDetectorRbArray;

@synthesize submitBtn;
@synthesize submitRequest;
@synthesize prepairedTxt,propertyAddTxt;

@synthesize ini_viewXposition;
//cleanliness cell 1
@synthesize cl1floor1RbArray,cl1wall1Rb1Array,cl1windows1Rb1Array,cl1curtains1Rb1Array,cl1furnishing1Rb1Array;

//cleanliness cell 2
@synthesize cl2floor2RbArray,cl2wall2RbArray,cl2windows2RbArray,cl2curtains2RbArray,cl2furnishing2RbArray;

//cleanliness cell 3
@synthesize cl3floor3RbArray,cl3wall3RbArray,cl3windows3RbArray,cl3curtains3RbArray,cl3furnishing3RbArray;

//cleanliness cell 4
@synthesize cl4floor4RbArray,cl4wall4RbArray,cl4windows4RbArray,cl4curtains4RbArray,cl4furnishing4RbArray;

//cleanliness cell 5
@synthesize cl5floor5RbArray,cl5wall5RbArray,cl5windows5RbArray,cl5curtains5RbArray,cl5furnishing5RbArray;

//cleanliness cell 6
@synthesize cl6floor6RbArray,cl6wall6RbArray,cl6windows6RbArray,cl6curtains6RbArray,cl6furnishing6RbArray;

//cleanliness cell 7
@synthesize cl7floor7RbArray,cl7wall7RbArray,cl7windows7RbArray,cl7curtains7RbArray,cl7furnishing7RbArray;

//cleanliness cell 8
@synthesize cl8floor8RbArray,cl8wall8RbArray,cl8windows8RbArray,cl8curtains8RbArray,cl8furnishing8RbArray;

@synthesize propertyAddressTxt,prepairedByTxt;
@synthesize loggedInUser,tokenValue;
@synthesize userlistRequest;
@synthesize baseView;
@synthesize cleanlinessBlock = _cleanlinessBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentExpandedIndex=-1;
    }
    
    return self;
}

-(NSMutableArray*) cleanlinessImagesURL {
    if(!_cleanlinessImagesURL) {
        _cleanlinessImagesURL = [[NSMutableArray alloc] init];
    }
    return _cleanlinessImagesURL;
}

-(NSMutableArray*) radioButtons {
    if(!_radioButtons) {
        _radioButtons = [[NSMutableArray alloc] init];
    }
    return _radioButtons;
}

-(BOOL) isCleanlinessCapturersLocked {
    return self.cleanlinessImageUploadInProgress;
}

-(CLCloudinary*) cloudinary {
    if (!_cloudinary) {
        _cloudinary = [[CLCloudinary alloc] init];//WithUrl:@"cloudinary://134456249416914:R7jQYMFDzd3GMN2-VILALNZrcGE@wisethapa"];
        
        [_cloudinary.config setValue:@"wisethapa" forKey:@"cloud_name"];
        [_cloudinary.config setValue:@"134456249416914" forKey:@"api_key"];
        [_cloudinary.config setValue:@"R7jQYMFDzd3GMN2-VILALNZrcGE" forKey:@"api_secret"];
    }
    return _cloudinary;
}

-(CLUploader*) cloudinaryUploader {
    if(!_cloudinaryUploader) {
        _cloudinaryUploader = [[CLUploader alloc] init:self.cloudinary delegate:self];
    }
    return _cloudinaryUploader;
}



-(void)submitBtnTapped:(UIButton*)sender{
    NSLog(@"this is submit button");
}

#pragma mark insertnewcleanlinessblock
-(void) insertNewCleanlinessBlock:(UIButton*) sender {
    UIView* newBlock = [self getCleanlinessBlock];
    CGRect cleanBlock = self.cleanlinessBlock.frame;
    
    newBlock.frame = CGRectMake(cleanBlock.size.width * self.page++, cleanBlock.origin.y, cleanBlock.size.width, cleanBlock.size.height);
    [self.cleanlinessScrollView addSubview:newBlock];
    [self.cleanlinessScrollView setContentSize:CGSizeMake(newBlock.frame.origin.x + newBlock.frame.size.width, 270)];
    [self updatePageControl];
}

-(void) updatePageControl {
    float pageIndexWidth = 10.0;
    float pageIndexHeight = 10.0;
    pageControl.numberOfPages=self.page;
    
    CGRect pageControlFrame = pageControl.frame;
    
    // increase the width of page control based on number of pages
    pageControlFrame.size.width = self.page * pageIndexWidth;
    pageControlFrame.size.height = pageIndexHeight;
    
    // center the page frame considering its width after a page has been added
    pageControlFrame.origin.x = (self.cleanlinessCell.frame.size.width - pageControlFrame.size.width) / 2;
    
    pageControlFrame.origin.y = 240.0;
    pageControl.frame = pageControlFrame;
}


-(UIView*) getCleanlinessBlock {
    ini_viewXposition = 0;
    self.cleanlinessBlock = [[UIView alloc] initWithFrame:CGRectMake(ini_viewXposition, 10.0, 765.0, 350.0)];
    [self generateTextFields];
    [self generateRadios];
    [self generateImageCapturers];
    [self createIndexForImagesArray];
    return self.cleanlinessBlock;
}
//scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = [self getCurrentPageForCleanlinessBlock];
}

-(NSInteger) getCurrentPageForCleanlinessBlock {
    CGFloat pageWidth = self.cleanlinessScrollView.frame.size.width;
    float fractionalPage = self.cleanlinessScrollView.contentOffset.x / pageWidth;
    return lround(fractionalPage);
}

// to avoid run time crash for non existing index
-(void) createIndexForImagesArray {
    NSArray* keys = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", nil];
    NSArray* objects = [[NSArray alloc] initWithObjects:@"NA", @"NA", @"NA", nil];
    [self.cleanlinessImagesURL addObject:[[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys]];
}

-(void) generateTextFields {
    UITextField *txtFieldForRoomTitle = [[UITextField alloc] initWithFrame:CGRectMake(15, 20, 250, 40)];
    txtFieldForRoomTitle.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    txtFieldForRoomTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    txtFieldForRoomTitle.backgroundColor=[UIColor whiteColor];
    txtFieldForRoomTitle.layer.borderWidth = 1.0f;
    txtFieldForRoomTitle.placeholder=@"Room Title";
    txtFieldForRoomTitle.tag = 12010 + (self.page + 1);
    txtFieldForRoomTitle.layer.borderColor = [[UIColor blackColor] CGColor];
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFieldForRoomTitle.leftView = paddingView;
    txtFieldForRoomTitle.leftViewMode = UITextFieldViewModeAlways;
    txtFieldForRoomTitle.userInteractionEnabled = YES;
    
    
    //second one
    UITextField *txtFieldForRoomDropDown = [[UITextField alloc] initWithFrame:CGRectMake(15, txtFieldForRoomTitle.frame.origin.y+55, 250, 40)];
    txtFieldForRoomDropDown.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    txtFieldForRoomDropDown.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    txtFieldForRoomDropDown.backgroundColor=[UIColor whiteColor];
    txtFieldForRoomDropDown.layer.borderWidth = 1.0f;
    txtFieldForRoomDropDown.delegate=self;
    txtFieldForRoomDropDown.placeholder=@"RoomDropDown";
    UIPickerView *roomTypePickerView=[[UIPickerView alloc]init];
    roomTypePickerView.delegate=self;
    roomTypePickerView.tag= 45454578;
    txtFieldForRoomDropDown.inputView = roomTypePickerView;
//    45454578
    txtFieldForRoomDropDown.inputAccessoryView=self.toolbar;
    txtFieldForRoomDropDown.text=[self.RoomTypeArray objectAtIndex:0];
    
    
    
    txtFieldForRoomDropDown.layer.borderColor = [[UIColor blackColor] CGColor];
    
    txtFieldForRoomDropDown.tag = 52010 + (self.page + 1);
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFieldForRoomDropDown.leftView = paddingView1;
    txtFieldForRoomDropDown.leftViewMode = UITextFieldViewModeAlways;
    txtFieldForRoomDropDown.userInteractionEnabled = YES;
    
    [self.cleanlinessBlock addSubview:txtFieldForRoomTitle];
    [self.cleanlinessBlock addSubview:txtFieldForRoomDropDown];
}

-(void) generateImageCapturers {
    float ini_btnCamX = 13.0;
    float ini_btnCamY = 140.0;
    float camBtnWidth = 72.0;
    float camBtnHeight = 71.0;
    
    UIImage* camImage = [UIImage imageNamed:@"SelectImage.png"];
    for (int i =0; i < [self.imagesButtons count]; i++) {
        UIButton* imageCapture = [[UIButton alloc ] initWithFrame:CGRectMake(ini_btnCamX, ini_btnCamY, camBtnWidth, camBtnHeight)];
        [imageCapture setImage:camImage forState:UIControlStateNormal];
        [imageCapture addTarget:self action:@selector(pickImageForCleanliness:) forControlEvents:UIControlEventTouchUpInside];
        imageCapture.tag = i;
        
        ini_btnCamX += camBtnWidth + 20;
        [self.cleanlinessBlock addSubview:imageCapture];
        imageCapture = nil;
    }
    [self.cleanlinessBlock setUserInteractionEnabled:YES];
}

-(void) generateRadios {
    
    float iniLabX = 330.0;
    float iniLabY = 20.0;
    float labWidth = 1.0;
    float labHeight = 20.0;
    float radioStartY = 20.0;
    
    float labHeightPadding = 20.0;
    
    float radioTitlePadding = 10;
    float radioPadding = 60;
    
    NSMutableArray* pageRadios = [[NSMutableArray alloc] init];
    for (int i =0; i <[self.listOfLabels count]; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(iniLabX, iniLabY, labWidth, labHeight)];
        [label setText:[self.listOfLabels objectAtIndex:i]];
        [label setTextColor:[UIColor lightGrayColor]];
        
        [label sizeToFit];
        iniLabY += labHeight + labHeightPadding;
        
        NSMutableArray* radioGroups = [[NSMutableArray alloc] init];
        NSArray* radioTexts = @[@"Yes", @"No", @"N/A"];
        
        float radioStartX = 440.0;
        radioStartY = label.frame.origin.y;
        for (int j =0; j < 3; j++) {
            
            RadioButton* rbtn = [[RadioButton alloc] init];
            rbtn.frame = CGRectMake(radioStartX, radioStartY - 5, 30.0, 30.0);
            [rbtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            
            UILabel *lbl_yesNo=[[UILabel alloc] init];
            lbl_yesNo.frame=CGRectMake((rbtn.frame.origin.x + rbtn.frame.size.width)+ radioTitlePadding , radioStartY, 30, labHeight);
            [lbl_yesNo setText:[radioTexts objectAtIndex:j]];
            lbl_yesNo.textColor = [UIColor lightGrayColor];
            rbtn.tag = i;
            
            [rbtn addTarget:self action:@selector(radioBtnHasBeenTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [radioGroups addObject:rbtn];
            
            radioStartX += lbl_yesNo.frame.size.width + radioPadding;
            
            [self.cleanlinessBlock addSubview:rbtn];
            [self.cleanlinessBlock addSubview:lbl_yesNo];
            
        }
        
        radioStartY += labHeight;
        
        ((RadioButton*)[radioGroups objectAtIndex:0]).groupButtons = @[[radioGroups objectAtIndex:0], [radioGroups objectAtIndex:1], [radioGroups objectAtIndex:2]];
        [pageRadios addObject:radioGroups];
        [self.cleanlinessBlock addSubview:label];
    }
    [self.radioButtons addObject:pageRadios];
}

-(void) radioBtnHasBeenTapped:(RadioButton*) sender {
    sender.selected = YES;
    
    CGFloat width = self.cleanlinessScrollView.frame.size.width;
    NSInteger page = (self.cleanlinessScrollView.contentOffset.x + (0.5f * width)) / width;
    
    
    // selected button from the group of radio button of whose member was tapped
    RadioButton* selectedRadioButtonInTheGroup = ((RadioButton*)[[[self.radioButtons objectAtIndex:page] objectAtIndex:sender.tag] objectAtIndex:0]).selectedButton;
    
    
    for (int i =0; i<3; i++) {
        
        
        RadioButton* loopedRadioButton = ((RadioButton*)[[[self.radioButtons objectAtIndex:page] objectAtIndex:sender.tag] objectAtIndex:i]);
        
        
        
        if (loopedRadioButton != selectedRadioButtonInTheGroup) {
            
            [loopedRadioButton setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            
        }
    }
    [sender setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
}

-(IBAction) pickImageForCleanliness:(id)sender {
    
    
    // prevent parallel image capture in this version
    if (self.isCleanlinessCapturersLocked) {
        return;
    }
    
    [self lockCleanlinessImageCapturers];
    self.activeCleanlinessPage = [self getCurrentPageForCleanlinessBlock];
    self.tappedCleanlinessButton = sender;
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Cleanliness" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a photo",@"Choose from existing one",@"Reset", nil] ;
    [actionSheet showInView:self.view];
}


-(IBAction)pickImage:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Cleanliness" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a photo",@"Choose from existing one",@"Reset", nil] ;
    UIButton *btn = (UIButton *)sender;
    NSLog(@"tag:%d",btn.tag);
    
    if(btn.tag==0){
        //[self setTagNo:0];
        firstBtnCliked=YES;
    }
    if(btn.tag==1){
        //[self setTagNo:1];
        secondBtnCliked = YES;
    }
    if(btn.tag==2){
        //[self setTagNo:2];
        thirdBtnCliked=YES;
    }
    if (btn.tag==100) {
        gutterBtnClicked=YES;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==101) {
        gutterBtnClicked=NO;
        windowsBtnClicked=YES;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==102) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=YES;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==103) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=YES;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==104) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=YES;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==105) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=YES;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==106) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=YES;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==107) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=YES;
        smokeDetectorBtnClicked=NO;
        
    }
    if (btn.tag==108) {
        gutterBtnClicked=NO;
        windowsBtnClicked=NO;
        wallsBtnCliked=NO;
        roofTileBtnCliked=NO;
        fencingBtnClicked=NO;
        gatesBtnClicked=NO;
        gardenBtnClicked=NO;
        commAreaBtnClicked=NO;
        smokeDetectorBtnClicked=YES;
        
    }
    
    
    // [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet showInView:self.view];
    
}

#pragma mark-Action Sheet method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        // open camera;
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            if( [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear ]){
                UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
                imagePicker.allowsEditing = NO;
                
                if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
                {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [self presentViewController:imagePicker animated:YES completion:nil];
                    }];
                    
                }
                else{
                    
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                
            }
        }
        else
        {
            [self unlockCleanlinessImageCapturers];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@ "Error"message:@"Your Device does not support camera" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:Nil, nil];
            [alert show];
        }
    }
    else if (buttonIndex ==1)
    {
        //open gallary
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] ) {
            UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init] ;
            [imagePicker setDelegate:self];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
            imagePicker.allowsEditing = NO;
            
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }];
                
            }
            else{
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
        
    }
    
    else
    {
        [self unlockCleanlinessImageCapturers];
        [self.tappedCleanlinessButton setBackgroundImage:[UIImage imageNamed:@"SelectImage.png"] forState:UIControlStateNormal];
    }
}


-(void) uploadCleanlinessImageToCloudinary:(UIImage*) imageToUpload {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cloudinaryUploader upload:UIImagePNGRepresentation(imageToUpload) options:@{}];
    });
}



-(void) lockCleanlinessImageCapturers {
    self.cleanlinessImageUploadInProgress = YES;
}

-(void) unlockCleanlinessImageCapturers {
    self.cleanlinessImageUploadInProgress = NO;
}

#pragma mark -
#pragma mark Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if (self.cleanlinessImageUploadInProgress) {
        [self.tappedCleanlinessButton setImage:image forState:UIControlStateNormal];
        [self uploadCleanlinessImageToCloudinary:image];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self unlockCleanlinessImageCapturers];
    if (cameraOpen) {
        cameraOpen = NO;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cleanlinessImageUploadInProgress = NO;
    [self badInitStartup];
}
-(void)dismissKeyboard{
    [self keyboardHide];
}

-(void)keyboardHide{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self badViewWillAppear];
}





-(void)updateTime
{
    NSDate *date= [NSDate date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init]; //for hour and minute
    
    formatter1.dateFormat = @"hh:mm a";// use any format
    // timeLbl.text = [formatter1 stringFromDate:date];
    
    self.inspectionCell.inspectionTimeTxt.text = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:date]];
    
    
}

- (void)expandItemAtIndex:(int)index {
    NSMutableArray *indexPaths = [NSMutableArray new];
    
    int insertPos = index + 1;
    [indexPaths addObject:[NSIndexPath indexPathForRow:insertPos++ inSection:0]];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)collapseSubItemsAtIndex:(int)index {
    NSMutableArray *indexPaths = [NSMutableArray new];
    int i = index + 1;
    [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}

- (IBAction)futureRadioBtn:(RadioButton*)sender{
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", sender.titleLabel.text]);
    //    self.installStr = [NSString stringWithFormat:@"Selected: %@", sender.titleLabel.text];
    //    NSLog(@"install value:%@", self.installStr);
    
}

#pragma TEXTFIELD DELEGATES
-(BOOL) textFieldShouldBeginEditing:(UITextField *)txtField
{
    if (txtField==self.futureVisitCell.futureDateTxt || txtField==self.declarationCell.declarationDateTxt || txtField==self.inspectionCell.inspectionDateTxt || txtField==self.inspectionCell.inspectionTimeTxt) {
        
        [self createDatePicker];
    }
    
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.toolbar setHidden:NO];
    [self.normalkeyboardtoolbar setHidden:NO];
    
    self.activeRoomTypeTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.propertyAddressTxt resignFirstResponder];
    [self.prepairedByTxt resignFirstResponder];
    
    [self.insuranceCell.policyNoTxt resignFirstResponder];
    
    [self.inspectionCell.inspectionDateTxt resignFirstResponder];
    [self.inspectionCell.inspectionTimeTxt resignFirstResponder];
    [self.inspectionCell.presentTxt resignFirstResponder];
    
    
}



#pragma TEXTVIEW DELEGATES
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [self.repairsCell.repairTxt resignFirstResponder];
    [self.noteBreakageCell.breakageTxt resignFirstResponder];
    [self.noteDamageCell.noteDamageTxt resignFirstResponder];
    [self.generalCommentsCell.generalCommentsTxt resignFirstResponder];
    [self.insuranceCell.insranceDetailTxtView resignFirstResponder];
    
    [self.declarationCell.teenantSignatureTxt resignFirstResponder];
    [self.declarationCell.behalfTxt resignFirstResponder];
    
    [self.commentsCell.gutterTxt resignFirstResponder];
    [self.commentsCell.windowTxt resignFirstResponder];
    [self.commentsCell.wallTxt resignFirstResponder];
    [self.commentsCell.roofTileTxt resignFirstResponder];
    [self.commentsCell.fencingTxt resignFirstResponder];
    [self.commentsCell.gatesTxt resignFirstResponder];
    [self.commentsCell.gardenTxt resignFirstResponder];
    [self.commentsCell.commAreaTxt resignFirstResponder];
    [self.commentsCell.smokeDetectorTxt resignFirstResponder];
    
    return  YES;
}
//for managing keyboard

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [self createToolBar];
    
}

- (void)textViewDidChange:(UITextView *)txtView
{
    
    //Outstanding repairs
    if (txtView==self.repairsCell.repairTxt)
    {
        self.repairsCell.repairPlaceholder.hidden = ([txtView.text length] > 0);
    }
    
    //general comments
    if (txtView==self.generalCommentsCell.generalCommentsTxt)
    {
        self.generalCommentsCell.generalCommmentsPlaceholder.hidden = ([txtView.text length] > 0);
    }
    
    
    
    if (txtView==self.noteDamageCell.noteDamageTxt)
    {
        self.noteDamageCell.damagePlaceholder.hidden = ([txtView.text length] > 0);
    }
    
    if (txtView==self.noteBreakageCell.breakageTxt)
    {
        self.noteBreakageCell.breakagePlaceholder.hidden = ([txtView.text length] > 0);
    }
    
    
    
    //visual comments placholder labels
    if (txtView==self.commentsCell.gutterTxt) {
        self.commentsCell.gutterPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.windowTxt) {
        self.commentsCell.windowsPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.wallTxt) {
        self.commentsCell.wallsPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.roofTileTxt) {
        self.commentsCell.rooftilesPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.fencingTxt) {
        self.commentsCell.fencingPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.gatesTxt) {
        self.commentsCell.gatesPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.gardenTxt) {
        self.commentsCell.gardenPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    if (txtView==self.commentsCell.commAreaTxt) {
        self.commentsCell.commAreaPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    
    if (txtView==self.commentsCell.smokeDetectorTxt) {
        self.commentsCell.smokeDetectorPlaceHolderLbl.hidden = ([txtView.text length] > 0);
    }
    
}

-(void)createToolBar{
    self.normalkeyboardtoolbar.hidden=NO;
    [normalkeyboardtoolbar sizeToFit];
    normalkeyboardtoolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(keyboardHide)],
                                   nil];
    
    
    normalkeyboardtoolbar.barStyle=UIBarStyleDefault;
    
    self.repairsCell.repairTxt.delegate=self;
    self.repairsCell.repairTxt.inputAccessoryView = self.normalkeyboardtoolbar;
    self.insuranceCell.insranceDetailTxtView.inputAccessoryView=self.normalkeyboardtoolbar;
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.repairsCell.repairTxt resignFirstResponder];
    
}

#pragma UIDatePicker Delegates

-(void)createDatePicker{
    self.datepickerView=[[UIDatePicker alloc]init];
    self.datepickerView.datePickerMode = UIDatePickerModeDate;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.toolbar.barStyle = UIBarStyleDefault;
    [self.toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(DatePickerCancelClick:)];
    [barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(DatePickerDoneClick:)];
    [barItems addObject:doneBtn];
    
    [self.toolbar setItems:barItems animated:YES];
    
    self.futureVisitCell.futureDateTxt.inputView = datepickerView;
    self.futureVisitCell.futureDateTxt.inputAccessoryView=self.toolbar;
    
    //    self.declarationCell.declarationDateTxt.inputView = datepickerView;
    // self.declarationCell.declarationDateTxt.inputAccessoryView=self.toolbar;
    
    //    self.inspectionCell.inspectionDateTxt.inputView = datepickerView;
    // self.inspectionCell.inspectionDateTxt.inputAccessoryView=self.toolbar;
    
    //    self.inspectionCell.inspectionTimeTxt.inputView = datepickerView;
    //self.inspectionCell.inspectionTimeTxt.inputAccessoryView=self.toolbar;
    
    
}
-(void)UserPickerDoneClick:(id)sender{
    self.prepairedByTxt.text = (NSString *)[self.userArray objectAtIndex:0];
    [self keyboardHide];
}



#pragma UIPicker Delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    //    if (pickerView==self.loggedInUserpickerVC) {
    //        return [self.userArray count];
    //    }
    ////    else
    ////    {
    ////      //  return [self.typeArray count];
    ////    }
    
    
    
    
    //return [self.userArray count];
    
     if(pickerView.tag==45454578){
        return  [self.RoomTypeArray count];
        
    }
    else{
        return [self.userArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    //    if (pickerView==self.sortOrderPickerView) {
    //        return  [self.sortOptionsArray objectAtIndex:row];
    //    }
    //    else
    //    {
    //        return  [self.typeArray objectAtIndex:row];
    //
    //    }
    
    
    if(pickerView.tag==45454578){
        return  [self.RoomTypeArray objectAtIndex:row];

    }
    else{
    return  [self.userArray objectAtIndex:row];
    }
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*if (pickerView==self.sortOrderPickerView) {
     self.sortOrderTxtfield.text = (NSString *)[self.sortOptionsArray objectAtIndex:row];
     }
     else
     {
     self.formTypetxtfield.text = (NSString *)[self.typeArray objectAtIndex:row];
     }
     */
    if(pickerView.tag==45454578){
        self.activeRoomTypeTextField.text = [self.RoomTypeArray objectAtIndex:row];
        
    }
    else{
        self.prepairedByTxt.text = (NSString *)[self.userArray objectAtIndex:row];}
    
    
}



//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    UILabel *pickerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
//    
//    pickerlabel.textAlignment=NSTextAlignmentCenter;
//    // pickerlabel.font=FONT_ROBOTO(14);
//    //if (IS_IPAD) {
//    //pickerlabel.font = FONT_ROBOTO(16);
//    //}
//    //    if (pickerView==self.sortOrderPickerView) {
//    //        pickerlabel.text = [NSString stringWithFormat:@" %@", [self.sortOptionsArray objectAtIndex:row]];
//    //    }
//    //    else{
//    //        pickerlabel.text = [NSString stringWithFormat:@" %@", [self.typeArray objectAtIndex:row]];
//    //    }
//    pickerlabel.text = [NSString stringWithFormat:@" %@", [self.userArray objectAtIndex:row]];
//    return pickerlabel;
//}

- (void)DatePickerDoneClick:(id)sender{
    
    
    NSDate *date=[self.datepickerView date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    if ([self.inspectionCell.inspectionTimeTxt isFirstResponder]){
        [df setDateFormat:@"h:mm a"];
        NSString *datestring;
        datestring = [df stringFromDate:date];
        
        self.inspectionCell.inspectionTimeTxt.text =[NSString stringWithFormat:@"%@",datestring];
    }
    else{
        [df setDateFormat:@"dd-MMM-yyyy"];
        
    }
    
    
    NSString *datestring;
    datestring = [df stringFromDate:date];
    
    if ([self.futureVisitCell.futureDateTxt isFirstResponder])
    {
        self.futureVisitCell.futureDateTxt.text =[NSString stringWithFormat:@"%@",datestring];
        
        
    }
    else if ([self.declarationCell.declarationDateTxt isFirstResponder])
        
    {
        self.declarationCell.declarationDateTxt.text =[NSString stringWithFormat:@"%@",datestring];
        
        
    }
    
    else{
        self.inspectionCell.inspectionDateTxt.text =[NSString stringWithFormat:@"%@",datestring];
    }
    [self.futureVisitCell.futureDateTxt resignFirstResponder];
    
    [self.declarationCell.declarationDateTxt resignFirstResponder];
    [self.inspectionCell.inspectionDateTxt resignFirstResponder];
    
    [self.inspectionCell.inspectionTimeTxt resignFirstResponder];
    
}
- (void)DatePickerCancelClick:(id)sender{
    [self.futureVisitCell.futureDateTxt resignFirstResponder];
    [self.declarationCell.declarationDateTxt resignFirstResponder];
    [self.inspectionCell.inspectionDateTxt resignFirstResponder];
    [self.inspectionCell.inspectionTimeTxt resignFirstResponder];
    
}
-(void)createBorder{
    
    // UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 15, 660, 120) cornerRadius:15.0];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.0];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    // shapeLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    
    shapeLayer.strokeColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.cornerRadius=5.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.tempRefCell.layer addSublayer:shapeLayer];
    
}

- (IBAction)submitReport:(id)sender {
    NSString *prepairedByName=[self.prepairedByTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *propertyAddress=[self.propertyAddressTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // [self check];
    //[self finalPost];
    // [self sampleFormat];
    
    
    
    if (prepairedByName.length == 0 || propertyAddress.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"'Property Address' and 'Prepaired By' fields both are compulsory." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        /*
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"All the fields are compulsory (for now only)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
         [alert show];
         */
    }
    
    else
    {
        [self sampleFormat];
    }
    
    
    
}

//  @{
//@"Fields": @[
//@{
//@"FieldName": @"Floors",
//@"DisplayLabel": @"Floors",
//@"DataType": @"string",
//@"IsRequired": @"true",
//@"Value":self.floor1Value,
//@"DisplayOrder": @"0"
//},
//@{
//@"FieldName": @"Walls",
//@"DisplayLabel": @"Walls",
//@"DataType": @"string",
//@"IsRequired": @"true",
//@"Value": self.walls1Value,
//@"DisplayOrder": @"1"
//},
//
//@{
//@"FieldName": @"Windows",
//@"DisplayLabel": @"Windows",
//@"DataType": @"string",
//@"IsRequired": @"true",
//@"Value": self.windows1Value,
//@"DisplayOrder": @"2"
//
//},
//@{
//@"FieldName": @"Curtains",
//@"DisplayLabel": @"Curtains",
//@"DataType": @"string",
//@"IsRequired": @"true",
//@"Value": self.curtains1Value,
//@"DisplayOrder": @"3"
//
//},
//
//@{
//@"FieldName": @"Furnishing",
//@"DisplayLabel": @"Furnishing",
//@"DataType": @"string",
//@"IsRequired": @"true",
//@"Value": self.furnishing1Value,
//@"DisplayOrder": @"4"
//
//},
//
//@{
//@"FieldName": @"leftImage",
//@"DisplayLabel": @"Add Image",
//@"DataType": @"image",
//@"IsRequired": @"true",
//@"Value":self.r1img1URL,
////@"Value":@"https://cloudinary.com/console/media_library#/dialog/image/upload/nzg7ptsk5tizejuybxre",
//@"DisplayOrder": @"0"
//},
//
//@{
//@"FieldName": @"middleImage",
//@"DisplayLabel": @"Add Image",
//@"DataType": @"image",
//@"IsRequired": @"true",
//@"Value":self.r1img2URL,
////@"Value":@"https://cloudinary.com/console/media_library#/dialog/image/upload/nzg7ptsk5tizejuybxre",
//@"DisplayOrder": @"0"
//},
//
//@{
//@"FieldName": @"rightImage",
//@"DisplayLabel": @"Add Image",
//@"DataType": @"image",
//@"IsRequired": @"true",
////@"Value":@"https://cloudinary.com/console/media_library#/dialog/image/upload/nzg7ptsk5tizejuybxre",
//@"Value":self.r1img3URL,
//@"DisplayOrder": @"0"
//}
//
//],
//}

-(NSMutableArray*) cleanlinessSectionDictionary {
    NSMutableArray* cleanlinessSectionsArray = [[NSMutableArray alloc] init];
    NSMutableArray* cleanlinessSectionsArrayChild = nil;
    
    for (int i =0; i < self.page; i++) {
        cleanlinessSectionsArrayChild = [[NSMutableArray alloc] init];
        NSMutableArray* blockDefinitions = [[NSMutableArray alloc] init];
        
        NSArray* keys = [NSArray arrayWithObjects:@"FieldName",
                         @"DisplayLabel",
                         @"DataType",
                         @"IsRequired",
                         @"Value",
                         @"DisplayOrder",nil];
        //        52010 12010
        UITextField* roomTitle = [self.view viewWithTag:(12010 + (i + 1))];
        UITextField* roomTypeDropDown = [self.view viewWithTag:(52010 + (i+1))];
        
        
        NSArray* radioKeys = [NSArray arrayWithObjects:@"Floors", @"Walls", @"Windows", @"Curtains", @"Furnishing", nil];
        NSArray* radioVals = [NSArray arrayWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
        
        NSMutableDictionary* radioDicts = [[NSMutableDictionary alloc] initWithObjects:radioVals forKeys:radioKeys];
        
        
        for (int j =0; j < 5; j++) {
            
            RadioButton* radioGroup = ((RadioButton*)[[[self.radioButtons objectAtIndex:i] objectAtIndex:j] objectAtIndex:0]);
            
            for (int k =0; k <3; k++) {
                
                RadioButton* loopedRadioButton = ((RadioButton*)[[[self.radioButtons objectAtIndex:i] objectAtIndex:j] objectAtIndex:k]);
                if (radioGroup.selectedButton == loopedRadioButton) {
                    [radioDicts setObject:[NSString stringWithFormat:@"%d", k] forKey:[radioKeys objectAtIndex:j]];
                }
            }
            
        }
        
        
        NSString* roomTitleText = ([roomTitle isKindOfClass:[UITextField class]]) ? roomTitle.text : @" ";
        NSString* roomTypeText = ([roomTypeDropDown isKindOfClass:[UITextField class]]) ? roomTypeDropDown.text : @" ";
        
        NSArray* floors = [NSArray arrayWithObjects:@"Floors", @"Floors", @"string", @"true", [radioDicts objectForKey:@"Floors"], @"0", nil];
        NSArray* walls = [NSArray arrayWithObjects:@"Walls", @"Walls", @"string", @"true", [radioDicts objectForKey:@"Walls"], @"1", nil];
        NSArray* windows = [NSArray arrayWithObjects:@"Windows", @"Windows", @"string", @"true", [radioDicts objectForKey:@"Windows"], @"2", nil];
        NSArray* curtains = [NSArray arrayWithObjects:@"Curtains", @"Curtains", @"string", @"true", [radioDicts objectForKey:@"Curtains"], @"3", nil];
        NSArray* furnishing = [NSArray arrayWithObjects:@"Furnishing", @"Furnishing", @"string", @"true", [radioDicts objectForKey:@"Furnishing"], @"4", nil];
        NSArray* roomTitleDef = [NSArray arrayWithObjects:@"RoomTitle", @"RoomTitle", @"string", @"true", roomTitleText, @"5", nil];
        NSArray* roomTypeDef = [NSArray arrayWithObjects:@"RoomType", @"RoomType", @"string", @"true", roomTypeText, @"6", nil];
        
        ;
        
        
        
        NSArray* imageLeft = [NSArray arrayWithObjects:@"ImageLeft", @"ImageLeft", @"imageURL", @"false", [[self.cleanlinessImagesURL objectAtIndex:i] objectForKey:@"0"], @"6", nil];
        NSArray* imageMid = [NSArray arrayWithObjects:@"ImageMid", @"ImageLeft", @"imageURL", @"false", [[self.cleanlinessImagesURL objectAtIndex:i] objectForKey:@"1"], @"6", nil];
        NSArray* imageRight = [NSArray arrayWithObjects:@"ImageRight", @"ImageLeft", @"imageURL", @"false", [[self.cleanlinessImagesURL objectAtIndex:i] objectForKey:@"2"], @"6", nil];
        
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:floors forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:walls forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:windows forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:curtains forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:furnishing forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:roomTitleDef forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:roomTypeDef forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:imageLeft forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:imageMid forKeys:keys]];
        [cleanlinessSectionsArrayChild addObject:[NSDictionary dictionaryWithObjects:imageRight forKeys:keys]];
        
        NSMutableArray* cleanBlock = [[NSMutableArray alloc] init];
        
        [cleanBlock addObject:cleanlinessSectionsArrayChild];
        
        [cleanlinessSectionsArray addObject:[[NSDictionary alloc] initWithObjects:cleanBlock forKeys:[NSArray arrayWithObject:@"Fields"]]];
        
    }
    return cleanlinessSectionsArray;
}


-(void)postDataToServer{
}
#pragma JSON FORMAT POST
-(void)sampleFormat
{
    
    
    
    NSLog(@"comment cell:%@",commentsCell.wallTxt.text);
    
    
    
    if(self.commentsCell.windowTxt.text==@""||self.commentsCell.wallTxt.text==@"" || self.commentsCell.roofTileTxt.text==@"" ||self.commentsCell.fencingTxt.text==@"" ||self.commentsCell.gutterTxt.text==@""
       ||self.commentsCell.gatesTxt.text==@"" || self.commentsCell.wallTxt.text==@"" ||self.commentsCell.commAreaTxt.text==@"" || self.commentsCell.smokeDetectorTxt.text==@""){
        self.commentsCell.windowTxt.text=@"N/A";
        self.commentsCell.wallTxt.text=@"N/A";
        self.commentsCell.roofTileTxt.text=@"N/A";
        self.commentsCell.fencingTxt.text=@"N/A";
        self.commentsCell.gatesTxt.text=@"N/A";
        self.commentsCell.wallTxt.text=@"N/A";
        self.commentsCell.commAreaTxt.text=@"N/A";
        self.commentsCell.smokeDetectorTxt.text=@"N/A";
        self.commentsCell.gutterTxt.text=@"N/A";
    }
    
    NSLog(@"logging cleanliness section %@", [self cleanlinessSectionDictionary]);
    
    NSLog(@"floor Value:%@",self.floor1Value);
    NSLog(@"wall Value:%@",self.walls1Value);
    NSLog(@"windows Value:%@",self.windows1Value);
    NSLog(@"curtains Value:%@",self.curtains1Value);
    NSLog(@"furnishing Value:%@",self.furnishing1Value);
    
    NSLog(@"future Visit:%@",self.isfuturevisitValue);
    
    NSLog(@"Insuranec:%@",self.isinsuranceValue);
    
    NSLog(@"visual gutter Value:%@",self.gutterValue);
    NSLog(@"visual windows Value:%@",self.windowsValue);
    NSLog(@"visual walls Value:%@",self.wallsValue);
    NSLog(@"visual roof/tiles Value:%@",self.roofTileValue);
    NSLog(@"visual fencing Value:%@",self.fencingValue);
    NSLog(@"visual gates Value:%@",self.gatesValue);
    NSLog(@"visual garden Value:%@",self.gardenValue);
    NSLog(@"visual commArea Value:%@",self.commAreaValue);
    NSLog(@"visual smoke detector Value:%@",self.smokeDetectorValue);
    
    
    NSLog(@"deteriorated Value:%@",self.isdeterioated);
    NSLog(@"condition Value:%@",self.isgoodCondition);
    
    if ([self.propertyAddressTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.propertyAddTxt=@"Null";
    }
    else{
        self.propertyAddTxt=self.propertyAddressTxt.text;
    }
    
    if ([self.prepairedByTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.prepairedTxt=@"Null";
    }
    else{
        self.prepairedTxt=self.prepairedByTxt.text;
    }
    
    NSLog(@"propertyAddressTxt:%@",self.propertyAddTxt);
    NSLog(@"prepairedByTxt:%@",self.prepairedTxt);
    
    
    if ([self.repairsCell.repairTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.outstandingRepairTxt=@"Null";
        
    }
    else
    {
        self.outstandingRepairTxt=self.repairsCell.repairTxt.text;
        
    }
    NSLog(@"outstandingRepairTxt:%@",self.outstandingRepairTxt);
    if ([self.generalCommentsCell.generalCommentsTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.GeneralCommentTxt=@"Null";
    }
    else{
        self.GeneralCommentTxt=self.generalCommentsCell.generalCommentsTxt.text;
        
    }
    NSLog(@"GeneralCommentTxt:%@",self.GeneralCommentTxt);
    if ([self.futureVisitCell.futureDateTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.FutureVisitDateTxt=@"Null";
    }
    else{
        self.FutureVisitDateTxt=self.futureVisitCell.futureDateTxt.text;
        
    }
    NSLog(@"FutureVisitDateTxt:%@",self.FutureVisitDateTxt);
    if ([self.insuranceCell.policyNoTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.InsurancePolicyNoTxt=@"Null";
    }
    else
    {
        self.InsurancePolicyNoTxt=self.insuranceCell.policyNoTxt.text;
    }
    NSLog(@"InsurancePolicyNoTxt:%@",self.InsurancePolicyNoTxt);
    
    if ([self.insuranceCell.insranceDetailTxtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.InsuranceDetailTxt=@"Null";
    }
    else{
        self.InsuranceDetailTxt=self.insuranceCell.insranceDetailTxtView.text;
    }
    NSLog(@"InsuranceDetailTxt:%@",self.InsuranceDetailTxt);
    if ([self.declarationCell.teenantSignatureTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.TenanatSignatureTxt=@"Null";
    }
    else{
        self.TenanatSignatureTxt=self.declarationCell.teenantSignatureTxt.text;
    }
    
    NSLog(@"TenanatSignatureTxt:%@",self.TenanatSignatureTxt);
    if ([self.declarationCell.behalfTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.OnTheBehalfOfTxt=@"Null";
        
    }
    else{
        self.OnTheBehalfOfTxt=self.declarationCell.behalfTxt.text;
    }
    
    NSLog(@"OnTheBehalfOfTxt:%@",self.OnTheBehalfOfTxt);
    if ([self.declarationCell.declarationDateTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.DeclarationDateTxt=@"Null";
    }
    else{
        self.DeclarationDateTxt=self.declarationCell.declarationDateTxt.text;
    }
    NSLog(@"DeclarationDateTxt:%@",self.DeclarationDateTxt);
    if ([self.inspectionCell.inspectionDateTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.InspectionDateTxt=@"Null";
    }
    else
    {
        self.InspectionDateTxt=self.inspectionCell.inspectionDateTxt.text;
    }
    
    NSLog(@"InspectionDateTxt:%@",self.InspectionDateTxt);
    if ([self.inspectionCell.inspectionTimeTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.InspectionTimeTxt=@"Null";
    }
    else{
        self.InspectionTimeTxt=self.inspectionCell.inspectionTimeTxt.text;
    }
    
    NSLog(@"InspectionTimeTxt:%@",self.InspectionTimeTxt);
    if ([self.inspectionCell.presentTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.InspectionPresentTxt=@"Null";
    }
    else{
        self.InspectionPresentTxt=self.inspectionCell.presentTxt.text;
    }
    NSLog(@"InspectionPresentTxt:%@",self.InspectionPresentTxt);
    
    
    
    if ([self.commentsCell.gutterTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.GutterCommentTxt=@"Null";
    }
    else{
        self.GutterCommentTxt=self.commentsCell.gutterTxt.text;
    }
    
    NSLog(@"GutterCommentTxt:%@",self.GutterCommentTxt);
    
    if ([self.commentsCell.windowTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.WindowCommentTxt=@"Null";
    }
    else{
        self.WindowCommentTxt=self.commentsCell.windowTxt.text;
    }
    NSLog(@"WindowCommentTxt:%@",self.WindowCommentTxt);
    
    
    if ([self.commentsCell.wallTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.WallCommentTxt=@"Null";
    }
    else{
        self.WallCommentTxt=self.commentsCell.wallTxt.text;
    }
    NSLog(@"WallCommentTxt:%@",self.WallCommentTxt);
    
    if ([self.commentsCell.roofTileTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.RoofTileCommentTxt=@"Null";
    }
    else{
        self.RoofTileCommentTxt=self.commentsCell.roofTileTxt.text;
    }
    NSLog(@"RoofTileCommentTxt:%@",self.RoofTileCommentTxt);
    if ([self.commentsCell.fencingTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.FencingCommentTxt=@"Null";
    }
    else{
        self.FencingCommentTxt=self.commentsCell.fencingTxt.text;
    }
    NSLog(@"FencingCommentTxt:%@",self.FencingCommentTxt);
    if ([self.commentsCell.gatesTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.GatesCommentTxt=@"Null";
    }
    else{
        self.GatesCommentTxt=self.commentsCell.gatesTxt.text;
    }
    NSLog(@"GatesCommentTxt:%@",self.GatesCommentTxt);
    if ([self.commentsCell.gardenTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.GardenCommentTxt=@"Null";
    }
    else{
        self.GardenCommentTxt=self.commentsCell.gardenTxt.text;
    }
    
    NSLog(@"GardenCommentTxt:%@",self.GardenCommentTxt);
    
    if ([self.commentsCell.commAreaTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.CommentAreaTxt=@"Null";
    }
    else{
        self.CommentAreaTxt=self.commentsCell.commAreaTxt.text;
    }
    NSLog(@"CommentAreaTxt:%@",self.CommentAreaTxt);
    if ([self.commentsCell.smokeDetectorTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.SmokeDetectorTxt=@"Null";
    }
    else{
        self.SmokeDetectorTxt=self.commentsCell.smokeDetectorTxt.text;
    }
    NSLog(@"SmokeDetectorTxt:%@",self.SmokeDetectorTxt);
    
    
    if ([self.noteDamageCell.noteDamageTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.damageCommentTxt=@"Null";
    }
    else{
        self.damageCommentTxt=self.noteDamageCell.noteDamageTxt.text;
    }
    NSLog(@"damageCommentTxt:%@",self.damageCommentTxt);
    
    if ([self.noteBreakageCell.breakageTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.breakageAreaTxt=@"Null";
    }
    else{
        self.breakageAreaTxt=self.noteBreakageCell.breakageTxt.text;
    }
    NSLog(@"breakageAreaTxt:%@",self.breakageAreaTxt);
    
    NSLog(@"r1img1URL:%@",r1img1URL);
    NSLog(@"r1img2URL:%@",r1img2URL);
    NSLog(@"r1img3URL:%@",r1img3URL);
    
    if ([r1img1URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        self.r1img1URL=@"N/A";
        
    }
    
    if ([r1img2URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.r1img2URL=@"N/A";
    }
    if ([r1img3URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        self.r1img3URL=@"N/A";
    }
    
    NSLog(@"r1img1URL:%@",r1img1URL);
    NSLog(@"r1img2URL:%@",r1img2URL);
    NSLog(@"r1img3URL:%@",r1img3URL);
    //"submission for property at {address}"
    
    NSString *title=[NSString stringWithFormat:@"submission for property at %@",self.propertyAddressTxt.text];
    NSDictionary *jsonDict =  @{
                                @"Company": @"Thehub Impact",
                                @"PropertyAddress":(self.propertyAddTxt)? self.propertyAddTxt : @"N/A",
                                @"PreparedBy":(self.prepairedTxt)? self.prepairedTxt : @"N/A",
                                @"title":title,
                                @"Groups": @[
                                        @{
                                            @"GroupName": @"Cleanliness",
                                            @"DisplayOrder": @"0",
                                            @"FieldGroups": [self cleanlinessSectionDictionary]
                                            },
                                        @{
                                            @"GroupName": @"Outstanding Repairs",
                                            @"DisplayOrder": @"1",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Repair_note",
                                                                    @"DisplayLabel": @"Repair note",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.outstandingRepairTxt)? self.outstandingRepairTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    }
                                                                ]
                                                        }
                                                    ]
                                            },
                                        @{
                                            @"GroupName": @"General Comments",
                                            @"DisplayOrder": @"2",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Comment",
                                                                    @"DisplayLabel": @"Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.GeneralCommentTxt) ? self.GeneralCommentTxt: @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    }
                                                                ]
                                                        }
                                                    ]
                                            },
                                        @{
                                            @"GroupName": @"Future Visits",
                                            @"DisplayOrder": @"3",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"isFutureVisit",
                                                                    @"DisplayLabel": @"Future Visits",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.isfuturevisitValue) ?self.isfuturevisitValue: @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    },
                                                                @{
                                                                    @"FieldName": @"Date",
                                                                    @"DisplayLabel": @"Date",
                                                                    @"DataType": @"datetime",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.FutureVisitDateTxt) ? self.FutureVisitDateTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    }
                                                                
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Insurance",
                                            @"DisplayOrder": @"4",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"isInsurance",
                                                                    @"DisplayLabel": @"Insurance",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.isinsuranceValue) ? self.isinsuranceValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"PolicyNo.",
                                                                    @"DisplayLabel": @"Policy No.",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.InsurancePolicyNoTxt) ? self.InsurancePolicyNoTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"Details",
                                                                    @"DisplayLabel": @"Details",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.InsuranceDetailTxt) ? self.InsuranceDetailTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    }
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Declaration",
                                            @"DisplayOrder": @"5",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Teenant_Signature",
                                                                    @"DisplayLabel": @"Teenant Signature",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.TenanatSignatureTxt) ? self.TenanatSignatureTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"On_Behalf_Of",
                                                                    @"DisplayLabel": @"On Behalf of",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.OnTheBehalfOfTxt) ? self.OnTheBehalfOfTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Date",
                                                                    @"DisplayLabel": @"Date",
                                                                    @"DataType": @"datetime",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.DeclarationDateTxt) ? self.DeclarationDateTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    }
                                                                
                                                                
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Inspection Date and Time",
                                            @"DisplayOrder": @"6",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Inspection_Date",
                                                                    @"DisplayLabel": @"Inspection Date",
                                                                    @"DataType": @"datetime",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.InspectionDateTxt) ?self.InspectionDateTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"Inspection_Time",
                                                                    @"DisplayLabel": @"Time",
                                                                    @"DataType": @"datetime",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.InspectionTimeTxt) ? self.InspectionTimeTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Present",
                                                                    @"DisplayLabel": @"Present",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.InspectionPresentTxt) ? self.InspectionPresentTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    }
                                                                
                                                                
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        
                                        @{
                                            @"GroupName": @"External-Basic Visual Comments",
                                            @"DisplayOrder": @"7",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Gutters",
                                                                    @"DisplayLabel": @"Gutters",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.gutterValue) ? self.gutterValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                  },
                                                                @{
                                                                    @"FieldName": @"Gutter_Comment",
                                                                    @"DisplayLabel": @"Gutter Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.GutterCommentTxt) ? self.GutterCommentTxt : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Windows",
                                                                    @"DisplayLabel": @"Windows",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.windowsValue) ? self.windowsValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Windows_Comment",
                                                                    @"DisplayLabel": @"Windows Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.windowTxt.text) ? self.commentsCell.windowTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"Walls",
                                                                    @"DisplayLabel": @"Walls",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.wallsValue) ? self.wallsValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Walls_Comment",
                                                                    @"DisplayLabel": @"Walls Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value":( self.commentsCell.wallTxt.text) ? self.commentsCell.wallTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Roof/Tiles",
                                                                    @"DisplayLabel": @"Roof/Tiles",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.roofTileValue) ? self.roofTileValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Roof_Tiles Comment",
                                                                    @"DisplayLabel": @"Roof/Tiles Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.roofTileTxt.text) ? self.commentsCell.roofTileTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Fencing",
                                                                    @"DisplayLabel": @"Fencing",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.fencingValue) ? self.fencingValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Fencing_Comment",
                                                                    @"DisplayLabel": @"Fencings Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.fencingTxt.text) ? self.commentsCell.fencingTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Gates",
                                                                    @"DisplayLabel": @"Gates",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.gatesValue) ? self.gatesValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Gates_Comment",
                                                                    @"DisplayLabel": @"Gates Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.gatesTxt.text)? self.commentsCell.gatesTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"Garden",
                                                                    @"DisplayLabel": @"Garden",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.gardenValue) ? self.gardenValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Garden_Comment",
                                                                    @"DisplayLabel": @"Garden Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.gardenTxt.text) ? self.commentsCell.gardenTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                @{
                                                                    @"FieldName": @"Comm_Area",
                                                                    @"DisplayLabel": @"Comm. Area",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value":(self.commAreaValue) ? self.commAreaValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Comm_Area_Comment",
                                                                    @"DisplayLabel": @"Comm. Area Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.commAreaTxt.text) ?  self.commentsCell.commAreaTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"Smoke_Detectors",
                                                                    @"DisplayLabel": @"Smoke Detectors",
                                                                    @"DataType": @"boolen",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.smokeDetectorValue) ? self.smokeDetectorValue : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                   },
                                                                @{
                                                                    @"FieldName": @"Smoke_Detectors_Comment",
                                                                    @"DisplayLabel": @"Smoke Detectors Comment",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.commentsCell.smokeDetectorTxt.text) ? self.commentsCell.smokeDetectorTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"                                                                    },
                                                                
                                                                
                                                                
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Note Any Damage",
                                            @"DisplayOrder": @"8",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Damage_Note",
                                                                    @"DisplayLabel": @"Note Any Damage",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value": (self.noteDamageCell.noteDamageTxt.text) ? self.noteDamageCell.noteDamageTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    }
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Note Any Breakages",
                                            @"DisplayOrder": @"9",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName": @"Breakages_Note",
                                                                    @"DisplayLabel": @"Note Any Breakages",
                                                                    @"DataType": @"string",
                                                                    @"IsRequired": @"false",
                                                                    @"Value":(self.noteBreakageCell.breakageTxt.text) ? self.noteBreakageCell.breakageTxt.text : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    }
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        @{
                                            @"GroupName": @"Final Words",
                                            @"DisplayOrder": @"10",
                                            @"FieldGroups": @[
                                                    @{
                                                        @"Fields": @[
                                                                @{
                                                                    @"FieldName":@"isPropertyDeteriorated",
                                                                    @"DisplayLabel": @"Has the property Deteriorated?",
                                                                    @"DataType": @"boolean",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.isdeterioated) ? self.isdeterioated : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    },
                                                                
                                                                @{
                                                                    @"FieldName": @"isPropertyInCondition",
                                                                    @"DisplayLabel": @"Is the property in good condition?",
                                                                    @"DataType": @"boolean",
                                                                    @"IsRequired": @"true",
                                                                    @"Value": (self.isgoodCondition) ? self.isgoodCondition : @"N/A",
                                                                    @"DisplayOrder": @"0"
                                                                    },
                                                                ]
                                                        }
                                                    ]
                                            },
                                        
                                        ]
                                };
    
    
    
    
    NSLog(@"jsonDic:%@",jsonDict);
    
    
    
    NSError *error;
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted error:&error];
 //  NSLog(@"jsondata:%@",jsonData);
    NSString *jsonString =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsondata:%@",jsonString);
    
    
    
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    
    NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/SmartHub/api/property/"];
    
    NSString *fixedURL = [URL
                          stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"::::%@",jsonString);
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    //[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    NSLog(@"data:::%@",[NSMutableData dataWithData:jsonData]);
    
    
    [request setPostBody:[NSMutableData dataWithData:jsonData]];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

-(void)getUserList{
    
    NSString *bearer=@"Bearer ";
    if (tokenValue.length!=0)
    {
        NSString *finalString = [bearer stringByAppendingString:tokenValue];
        NSLog(@"finalString:%@",finalString);
        NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.smarthub/api/users/me"];
        NSString *fixedURL = [URL
                              
                              stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // ?page=1&perpage=100&$orderby=CreatedDate
        
        NSURL *url = [NSURL URLWithString:fixedURL];
        
        
        
        userlistRequest = [ASIHTTPRequest requestWithURL:url];
        
        [userlistRequest setRequestMethod:@"GET"];
        
        [userlistRequest addRequestHeader:@"Accept" value:@"application/json"];
        
        [userlistRequest addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        
        [userlistRequest addRequestHeader:@"Authorization" value:finalString];
        [userlistRequest setDelegate:self];
        
        [userlistRequest startAsynchronous];
        
    }
    
    
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    
    NSString *responseString = [request responseString];
    NSLog(@"*****response::::::::::%@",responseString);
    if (request==self.userlistRequest)
    {
        NSMutableDictionary *dic=[responseString JSONValue];
        self.loggedInUser=[dic valueForKey:@"Username"];
        NSLog(@"username:%@",[dic valueForKey:@"Username"]);
        NSLog(@"username:%@",self.loggedInUser);
        self.userArray=[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@",self.loggedInUser], nil];
        
        self.prepairedByTxt.text = self.loggedInUser;
    }
    else
    {
        //NSMutableDictionary *dict=[responseString ]
        UIAlertView *successAlert=[[UIAlertView alloc]initWithTitle:@"posted" message:[responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [successAlert show];
    }
    
    
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
    
    NSLog(@"request:*****%@",error.localizedDescription);
    
    UIAlertView *failureAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [failureAlert show];
    
    
}


#pragma mark Cloudinary Delegates

- (void) uploaderSuccess:(NSDictionary*)result context:(id)context {
    
    if (self.isCleanlinessCapturersLocked) {
        NSMutableDictionary* urlsForBlock = [self.cleanlinessImagesURL objectAtIndex:self.activeCleanlinessPage];
        [urlsForBlock setObject:[result objectForKey:@"secure_url"] forKey:[NSString stringWithFormat:@"%ld", (long)self.tappedCleanlinessButton.tag]];
        [self unlockCleanlinessImageCapturers];
    }
    
    NSString* publicId = [result valueForKey:@"public_id"];
    NSLog(@"Upload success. Public ID=%@, Full result=%@", publicId, result);
    
}

- (void) uploaderError:(NSString*)result code:(int) code context:(id)context {
    
    if (self.isCleanlinessCapturersLocked) {
        [self unlockCleanlinessImageCapturers];
    }
    
    NSLog(@"Upload error: %@, %d", result, code);
}

- (void) uploaderProgress:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite context:(id)context {
    
    if (self.isCleanlinessCapturersLocked) {
        NSLog(@"Upload progress for cleanliness image : %d/%d (+%d)", totalBytesWritten, totalBytesExpectedToWrite, bytesWritten);
        
    }
}

- (IBAction)cloudTest:(id)sender {
    // CLCloudinary *cloudinary = [[CLCloudinary alloc] initWithUrl: @"cloudinary://917845251565494:ax13AJ8tIZ3Z2yL2GjjXx_APTcE@dym11jnwp"];
    /*
     CLCloudinary *cloudinary = [[CLCloudinary alloc] initWithUrl: [NSString stringWithFormat:@"cloudinary://%@:%@@%@",CLOUD_API_KEY,CLOUD_API_SECRET,CLOUD_NAME]];
     
     cloudinary = [[CLCloudinary alloc] initWithUrl:CLOUD_URL];
     
     CLUploader *uploader = [[CLUploader alloc] init:cloudinary delegate:self];
     NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:@"gutter" ofType:@"jpeg"];
     
     NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath];
     [uploader upload:imageData options:@{}];
     
     //[uploader upload:imageFilePath options:@{}];
     */
    
}
- (IBAction)clearnLinesBtnTapped:(id)sender {
}

- (IBAction)cleanBtnTap:(id)sender {
    
    cleanVC *vc=[[cleanVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)getAddress:(id)sender {
    
    
    //SPGooglePlacesAutocompleteViewController *svc=[[SPGooglePlacesAutocompleteViewController alloc]initWithNibName:@"SPGooglePlacesAutocompleteViewController" bundle:nil];
    
    LocationSuggestionView *svc=[[LocationSuggestionView alloc]initWithNibName:@"LocationSuggestionView" bundle:nil];
    
    
    svc.myDelegate=self;
    svc.modalPresentationStyle = UIModalPresentationFormSheet;
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:svc animated:YES completion:nil];
    svc.view.superview.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin;
    svc.view.superview.frame = CGRectMake(184, 70, 400, 685);
    svc.view.superview.layer.cornerRadius = 10.0f;
    
    //[self.navigationController pushViewController:svc animated:YES];
}


#pragma Second View Delegates
-(void) secondViewControllerDismissed:(NSString *)stringForFirst forTxtfld:(UITextField *)txt
{
    
    NSString *selectedlocation = stringForFirst;
    self.propertyAddressTxt.text=selectedlocation;
    
    
}

#pragma marks radio button clicked


- (IBAction)radioButtonPressed:(UIButton *)button
{
    [button setSelected:YES];
    // Unselect all others.
    for (UIButton *other in futureVisitRbArray) {
        if (other != button) {
            other.selected=NO;
        }
    }
    NSLog(@"value:%@",[NSString stringWithFormat:@"Selected: %@", button.titleLabel.text]);
    self.isfuturevisitValue=button.titleLabel.text;
}

- (IBAction)finalradioButtonPressed:(UIButton *)buttonone
{
    [buttonone setSelected:YES];
    // Unselect all others.
    for (UIButton *otherbtnone in finalwordsRbArray) {
        if (otherbtnone != buttonone) {
            otherbtnone.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", buttonone.titleLabel.text]);
    self.isdeterioated=buttonone.titleLabel.text;
}

- (IBAction)finalradioButtontwoPressed:(UIButton *)buttontwo
{
    [buttontwo setSelected:YES];
    // Unselect all others.
    for (UIButton *others in finalwordsRbArray2) {
        if (others != buttontwo) {
            others.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", buttontwo.titleLabel.text]);
    self.isgoodCondition=buttontwo.titleLabel.text;
}


- (IBAction)insuranceRadioButtonPressed:(UIButton *)insurancebutton
{
    [insurancebutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othersinsurance in insuranceRbArray) {
        if (othersinsurance != insurancebutton) {
            othersinsurance.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", insurancebutton.titleLabel.text]);
    self.isinsuranceValue=insurancebutton.titleLabel.text;
}

-(IBAction)gutterRadioButtonPressed:(UIButton *)gutterRadiobutton{
    
    [gutterRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othergutter in gutterRbArray) {
        if (othergutter != gutterRadiobutton) {
            othergutter.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", gutterRadiobutton.titleLabel.text]);
    self.gutterValue=gutterRadiobutton.titleLabel.text;
}
- (IBAction)windowRadioButtonPressed:(UIButton *)windowRadiobutton
{
    [windowRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwindow in windowsRbArray) {
        if (otherwindow != windowRadiobutton) {
            otherwindow.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", windowRadiobutton.titleLabel.text]);
    self.windowsValue=windowRadiobutton.titleLabel.text;
}

- (IBAction)wallsRadioButtonPressed:(UIButton *)wallsRadiobutton
{
    [wallsRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwalls in wallsRbArray) {
        if (otherwalls != wallsRadiobutton) {
            otherwalls.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wallsRadiobutton.titleLabel.text]);
    self.wallsValue=wallsRadiobutton.titleLabel.text;
}

- (IBAction)roofRadioButtonPressed:(UIButton *)roofRadiobutton
{
    [roofRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherroof in roofRbArray) {
        if (otherroof != roofRadiobutton) {
            otherroof.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", roofRadiobutton.titleLabel.text]);
    self.roofTileValue=roofRadiobutton.titleLabel.text;
}
- (IBAction)fencingRadioButtoPressed:(UIButton *)fencingRadiobutton
{
    [fencingRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherFencing in fencingRbArray) {
        if (otherFencing != fencingRadiobutton) {
            otherFencing.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fencingRadiobutton.titleLabel.text]);
    self.fencingValue=fencingRadiobutton.titleLabel.text;
}

- (IBAction)gateRadioButtonPressed:(UIButton *)gateRadiobutton
{
    [gateRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othergate in gatesRbArray) {
        if (othergate != gateRadiobutton) {
            othergate.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", gateRadiobutton.titleLabel.text]);
    self.gatesValue=gateRadiobutton.titleLabel.text;
}
- (IBAction)gardenRadioButtonPressed:(UIButton *)gardenRadiobutton
{
    [gardenRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othergarden in gardenRbArray) {
        if (othergarden != gardenRadiobutton) {
            othergarden.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", gardenRadiobutton.titleLabel.text]);
    self.gardenValue=gardenRadiobutton.titleLabel.text;
}

- (IBAction)comAreaRadioButtonPressed:(UIButton *)comAreaRadiobutton
{
    [comAreaRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercomArea in comAreaRbArray) {
        if (othercomArea != comAreaRadiobutton) {
            othercomArea.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", comAreaRadiobutton.titleLabel.text]);
    self.commAreaValue=comAreaRadiobutton.titleLabel.text;
}

- (IBAction)smokeDetectorsRadioButtonPressed:(UIButton *)smokeDetectorRadiobutton
{
    [smokeDetectorRadiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othersmokeDetector in smokeDetectorRbArray) {
        if (othersmokeDetector != smokeDetectorRadiobutton) {
            othersmokeDetector.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", smokeDetectorRadiobutton.titleLabel.text]);
    
    self.smokeDetectorValue=smokeDetectorRadiobutton.titleLabel.text;
}



// floor 1-cleanliness1
- (IBAction)fl1RadioButtonPressed:(UIButton *)fl1Radiobutton
{
    [fl1Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl1 in cl1floor1RbArray) {
        if (otherfl1 != fl1Radiobutton) {
            otherfl1.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl1Radiobutton.titleLabel.text]);
    self.floor1Value=fl1Radiobutton.titleLabel.text;
}

//walls 1-cleanliness1
- (IBAction)wa1RadioButtonPressed:(UIButton *)wa1Radiobutton
{
    [wa1Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa1 in cl1wall1Rb1Array) {
        if (otherwa1 != wa1Radiobutton) {
            otherwa1.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa1Radiobutton.titleLabel.text]);
    self.walls1Value=wa1Radiobutton.titleLabel.text;
}


//windows 1-cleanliness1
- (IBAction)wi1RadioButtonPressed:(UIButton *)wi1Radiobutton
{
    [wi1Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi1 in cl1windows1Rb1Array) {
        if (otherwi1 != wi1Radiobutton) {
            otherwi1.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi1Radiobutton.titleLabel.text]);
    self.windows1Value=wi1Radiobutton.titleLabel.text;
}

//curtains 1-cleanliness1
- (IBAction)cu1RadioButtonPressed:(UIButton *)cu1Radiobutton
{
    [cu1Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu1 in cl1curtains1Rb1Array) {
        if (othercu1 != cu1Radiobutton) {
            othercu1.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu1Radiobutton.titleLabel.text]);
    self.curtains1Value=cu1Radiobutton.titleLabel.text;
}


//furnishing 1-cleanliness1
- (IBAction)fur1RadioButtonPressed:(UIButton *)fur1Radiobutton
{
    [fur1Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu1 in cl1furnishing1Rb1Array) {
        if (otherfu1 != fur1Radiobutton) {
            otherfu1.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur1Radiobutton.titleLabel.text]);
    self.furnishing1Value=fur1Radiobutton.titleLabel.text;
    NSLog(@"furnishing1Value:%@",self.furnishing1Value);
}



//cleanliness 2 cell
// floor 2-cleanliness2
- (IBAction)fl2RadioButtonPressed:(UIButton *)fl2Radiobutton
{
    [fl2Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl2 in cl2floor2RbArray) {
        if (otherfl2 != fl2Radiobutton) {
            otherfl2.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl2Radiobutton.titleLabel.text]);
}

//walls 2-cleanliness2
- (IBAction)wa2RadioButtonPressed:(UIButton *)wa2Radiobutton
{
    [wa2Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa2 in cl2wall2RbArray) {
        if (otherwa2 != wa2Radiobutton) {
            otherwa2.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa2Radiobutton.titleLabel.text]);
}


//windows 2-cleanliness2
- (IBAction)wi2RadioButtonPressed:(UIButton *)wi2Radiobutton
{
    [wi2Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi2 in cl2windows2RbArray) {
        if (otherwi2 != wi2Radiobutton) {
            otherwi2.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi2Radiobutton.titleLabel.text]);
}

//curtains 2-cleanliness2
- (IBAction)cu2RadioButtonPressed:(UIButton *)cu2Radiobutton
{
    [cu2Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu2 in cl2curtains2RbArray) {
        if (othercu2 != cu2Radiobutton) {
            othercu2.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu2Radiobutton.titleLabel.text]);
}


//furnishing 2-cleanliness2
- (IBAction)fur2RadioButtonPressed:(UIButton *)fur2Radiobutton
{
    [fur2Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu2 in cl2furnishing2RbArray) {
        if (otherfu2 != fur2Radiobutton) {
            otherfu2.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur2Radiobutton.titleLabel.text]);
}





//cleanliness 3 cell
// floor 3-cleanliness3
- (IBAction)fl3RadioButtonPressed:(UIButton *)fl3Radiobutton
{
    [fl3Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl3 in cl3floor3RbArray) {
        if (otherfl3 != fl3Radiobutton) {
            otherfl3.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl3Radiobutton.titleLabel.text]);
}

//walls 3-cleanliness3
- (IBAction)wa3RadioButtonPressed:(UIButton *)wa3Radiobutton
{
    [wa3Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa3 in cl3wall3RbArray) {
        if (otherwa3 != wa3Radiobutton) {
            otherwa3.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa3Radiobutton.titleLabel.text]);
}


//windows 3-cleanliness3
- (IBAction)wi3RadioButtonPressed:(UIButton *)wi3Radiobutton
{
    [wi3Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi3 in cl3windows3RbArray) {
        if (otherwi3 != wi3Radiobutton) {
            otherwi3.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi3Radiobutton.titleLabel.text]);
}

//curtains 3-cleanliness3
- (IBAction)cu3RadioButtonPressed:(UIButton *)cu3Radiobutton
{
    [cu3Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu3 in cl3curtains3RbArray) {
        if (othercu3 != cu3Radiobutton) {
            othercu3.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu3Radiobutton.titleLabel.text]);
}


//furnishing 3-cleanliness3
- (IBAction)fur3RadioButtonPressed:(UIButton *)fur3Radiobutton
{
    [fur3Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu3 in cl3furnishing3RbArray) {
        if (otherfu3 != fur3Radiobutton) {
            otherfu3.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur3Radiobutton.titleLabel.text]);
}




//cleanliness 4 cell
// floor 4-cleanliness4
- (IBAction)fl4RadioButtonPressed:(UIButton *)fl4Radiobutton
{
    [fl4Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl4 in cl4floor4RbArray) {
        if (otherfl4 != fl4Radiobutton) {
            otherfl4.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl4Radiobutton.titleLabel.text]);
}

//walls 4-cleanliness4
- (IBAction)wa4RadioButtonPressed:(UIButton *)wa4Radiobutton
{
    [wa4Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa4 in cl4wall4RbArray) {
        if (otherwa4 != wa4Radiobutton) {
            otherwa4.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa4Radiobutton.titleLabel.text]);
}


//windows 4-cleanliness4
- (IBAction)wi4RadioButtonPressed:(UIButton *)wi4Radiobutton
{
    [wi4Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi4 in cl4windows4RbArray) {
        if (otherwi4 != wi4Radiobutton) {
            otherwi4.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi4Radiobutton.titleLabel.text]);
}

//curtains 4-cleanliness4
- (IBAction)cu4RadioButtonPressed:(UIButton *)cu4Radiobutton
{
    [cu4Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu4 in cl4curtains4RbArray) {
        if (othercu4 != cu4Radiobutton) {
            othercu4.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu4Radiobutton.titleLabel.text]);
}


//furnishing 4-cleanliness4
- (IBAction)fur4RadioButtonPressed:(UIButton *)fur4Radiobutton
{
    [fur4Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu4 in cl4furnishing4RbArray) {
        if (otherfu4 != fur4Radiobutton) {
            otherfu4.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur4Radiobutton.titleLabel.text]);
}








//cleanliness 5 cell
// floor 5-cleanliness5
- (IBAction)fl5RadioButtonPressed:(UIButton *)fl5Radiobutton
{
    [fl5Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl5 in cl5floor5RbArray) {
        if (otherfl5 != fl5Radiobutton) {
            otherfl5.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl5Radiobutton.titleLabel.text]);
}

//walls 5-cleanliness5
- (IBAction)wa5RadioButtonPressed:(UIButton *)wa5Radiobutton
{
    [wa5Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa5 in cl5wall5RbArray) {
        if (otherwa5 != wa5Radiobutton) {
            otherwa5.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa5Radiobutton.titleLabel.text]);
}


//windows 5-cleanliness5
- (IBAction)wi5RadioButtonPressed:(UIButton *)wi5Radiobutton
{
    [wi5Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi5 in cl5windows5RbArray) {
        if (otherwi5 != wi5Radiobutton) {
            otherwi5.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi5Radiobutton.titleLabel.text]);
}

//curtains 5-cleanliness5
- (IBAction)cu5RadioButtonPressed:(UIButton *)cu5Radiobutton
{
    [cu5Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu5 in cl5curtains5RbArray) {
        if (othercu5 != cu5Radiobutton) {
            othercu5.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu5Radiobutton.titleLabel.text]);
}


//furnishing 5-cleanliness5
- (IBAction)fur5RadioButtonPressed:(UIButton *)fur5Radiobutton
{
    [fur5Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu5 in cl5furnishing5RbArray) {
        if (otherfu5 != fur5Radiobutton) {
            otherfu5.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur5Radiobutton.titleLabel.text]);
}


//cleanliness 6 cell
// floor 6-cleanliness5
- (IBAction)fl6RadioButtonPressed:(UIButton *)fl6Radiobutton
{
    [fl6Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl6 in cl6floor6RbArray) {
        if (otherfl6 != fl6Radiobutton) {
            otherfl6.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl6Radiobutton.titleLabel.text]);
}

//walls 6-cleanliness6
- (IBAction)wa6RadioButtonPressed:(UIButton *)wa6Radiobutton
{
    [wa6Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa6 in cl6wall6RbArray) {
        if (otherwa6 != wa6Radiobutton) {
            otherwa6.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa6Radiobutton.titleLabel.text]);
}


//windows 6-cleanliness6
- (IBAction)wi6RadioButtonPressed:(UIButton *)wi6Radiobutton
{
    [wi6Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi6 in cl6windows6RbArray) {
        if (otherwi6 != wi6Radiobutton) {
            otherwi6.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi6Radiobutton.titleLabel.text]);
}

//curtains 6-cleanliness6
- (IBAction)cu6RadioButtonPressed:(UIButton *)cu6Radiobutton
{
    [cu6Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu6 in cl6curtains6RbArray) {
        if (othercu6 != cu6Radiobutton) {
            othercu6.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu6Radiobutton.titleLabel.text]);
}


//furnishing 6-cleanliness6
- (IBAction)fur6RadioButtonPressed:(UIButton *)fur6Radiobutton
{
    [fur6Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu6 in cl6furnishing6RbArray) {
        if (otherfu6 != fur6Radiobutton) {
            otherfu6.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur6Radiobutton.titleLabel.text]);
}



//cleanliness 7 cell
// floor 7-cleanliness7
- (IBAction)fl7RadioButtonPressed:(UIButton *)fl7Radiobutton
{
    [fl7Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl7 in cl7floor7RbArray) {
        if (otherfl7 != fl7Radiobutton) {
            otherfl7.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl7Radiobutton.titleLabel.text]);
}

//walls 7-cleanliness7
- (IBAction)wa7RadioButtonPressed:(UIButton *)wa7Radiobutton
{
    [wa7Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa7 in cl7wall7RbArray) {
        if (otherwa7 != wa7Radiobutton) {
            otherwa7.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa7Radiobutton.titleLabel.text]);
}


//windows 7-cleanliness7
- (IBAction)wi7RadioButtonPressed:(UIButton *)wi7Radiobutton
{
    [wi7Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi7 in cl7windows7RbArray) {
        if (otherwi7 != wi7Radiobutton) {
            otherwi7.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi7Radiobutton.titleLabel.text]);
}

//curtains 7-cleanliness7
- (IBAction)cu7RadioButtonPressed:(UIButton *)cu7Radiobutton
{
    [cu7Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu7 in cl7curtains7RbArray) {
        if (othercu7 != cu7Radiobutton) {
            othercu7.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu7Radiobutton.titleLabel.text]);
}


//furnishing 7-cleanliness7
- (IBAction)fur7RadioButtonPressed:(UIButton *)fur7Radiobutton
{
    [fur7Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu7 in cl7furnishing7RbArray) {
        if (otherfu7 != fur7Radiobutton) {
            otherfu7.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur7Radiobutton.titleLabel.text]);
}





//cleanliness 8 cell
// floor 8-cleanliness8
- (IBAction)fl8RadioButtonPressed:(UIButton *)fl8Radiobutton
{
    [fl8Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfl8 in cl8floor8RbArray) {
        if (otherfl8 != fl8Radiobutton) {
            otherfl8.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fl8Radiobutton.titleLabel.text]);
}

//walls 8-cleanliness8
- (IBAction)wa8RadioButtonPressed:(UIButton *)wa8Radiobutton
{
    [wa8Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwa8 in cl8wall8RbArray) {
        if (otherwa8 != wa8Radiobutton) {
            otherwa8.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wa8Radiobutton.titleLabel.text]);
}


//windows 8-cleanliness8
- (IBAction)wi8RadioButtonPressed:(UIButton *)wi8Radiobutton
{
    [wi8Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherwi8 in cl8windows8RbArray) {
        if (otherwi8 != wi8Radiobutton) {
            otherwi8.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", wi8Radiobutton.titleLabel.text]);
}

//curtains 8-cleanliness8
- (IBAction)cu8RadioButtonPressed:(UIButton *)cu8Radiobutton
{
    [cu8Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *othercu8 in cl8curtains8RbArray) {
        if (othercu8 != cu8Radiobutton) {
            othercu8.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", cu8Radiobutton.titleLabel.text]);
}


//furnishing 8-cleanliness8
- (IBAction)fur8RadioButtonPressed:(UIButton *)fur8Radiobutton
{
    [fur8Radiobutton setSelected:YES];
    // Unselect all others.
    for (UIButton *otherfu8 in cl8furnishing8RbArray) {
        if (otherfu8 != fur8Radiobutton) {
            otherfu8.selected=NO;
        }
    }
    NSLog(@"%@",[NSString stringWithFormat:@"Selected: %@", fur8Radiobutton.titleLabel.text]);
}



-(void) badInitStartup {

    
    self.listOfLabels = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"Floors", @"Walls", @"Windows", @"Curtains", @"Furnishing",nil]];
    self.imagesButtons = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"Reception1", @"Reception2", @"Reception3", nil]];
    RoomTypeArray=[[NSArray alloc]init];
    RoomTypeArray = @[@"Bathroom",
                      @"Bedroom 1",
                      @"Bedroom 2",
                      @"Bedroom 3",
                      @"Bedroom 4",
                      @"Cloaks",
                      @"Dining room",
                      @"En-suite",
                      @"Entrance hall",
                      @"Front garden",
                      @"Garage",
                      @"Hall",
                      @"Kitchen",
                      @"Landing",
                      @"Lounge",
                      @"Porch",
                      @"Rear garden",
                      @"Sitting room",
                      @"Utility room",
                      @"W.C"];
    
    
    self.page=0;
    
    
    
    
    //    typeOfRoom = [[UIPickerView alloc] initWithFrame:CGRectZero];
    //    [typeOfRoom setDataSource: self];
    //    [typeOfRoom setDelegate: self];
    //    typeOfRoom.showsSelectionIndicator = YES;
    //    txtFieldForRoomDropDown.inputView = typeOfRoom;
    //
    //    txtFieldForRoomDropDown.inputAccessoryView=self.toolbar;
    //    txtFieldForRoomDropDown.text=[self.RoomTypeArray objectAtIndex:0];
    
    // Do any additional setup after loading the view from its nib.
    
    //token set
    self.tokenValue = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    
    //cleanliness 1
    isfirst=NO;
    issecond=NO;
    isthird=NO;
    string=@"Null";
    self.outstandingRepairTxt=@"Null";
    
    self.GeneralCommentTxt=@"Null";
    
    self.FutureVisitDateTxt=string;
    
    self.InsurancePolicyNoTxt=string;
    self.InsuranceDetailTxt=string;
    self.TenanatSignatureTxt=string;
    
    self.OnTheBehalfOfTxt=string;
    self.DeclarationDateTxt=string;
    self.InspectionDateTxt=string;
    
    self.InspectionTimeTxt=string;
    self.InspectionPresentTxt=string;
    
    self.GutterCommentTxt=string;
    self.WindowCommentTxt=string;
    self.WallCommentTxt=string;
    self.RoofTileCommentTxt=string;
    self.FencingCommentTxt=string;
    self.GatesCommentTxt=string;
    self.GardenCommentTxt=string;
    self.CommentAreaTxt=string;
    self.SmokeDetectorTxt=string;
    
    self.breakageAreaTxt=@"Null";
    self.damageCommentTxt=@"Null";
    
    
    self.floor1Value=@"YES";
    self.walls1Value=@"YES";
    self.windows1Value=@"YES";
    self.curtains1Value=@"YES";
    self.furnishing1Value=@"YES";
    
    self.isfuturevisitValue=@"YES";
    self.isinsuranceValue=@"YES";
    
    //visual comments
    self.gutterValue=@"YES";
    self.windowsValue=@"YES";
    self.wallsValue=@"YES";
    self.roofTileValue=@"YES";
    self.fencingValue=@"YES";
    self.gatesValue=@"YES";
    self.gardenValue=@"YES";
    self.commAreaValue=@"YES";
    self.smokeDetectorValue=@"YES";
    
    self.isdeterioated=@"YES";
    self.isgoodCondition=@"YES";
    
    
    
    
    self.r1img1=[UIImage imageNamed:@"SelectImage.png"];
    self.r1img2=[UIImage imageNamed:@"SelectImage.png"];
    self.r1img3=[UIImage imageNamed:@"SelectImage.png"];
    self.r1img1URL=nil;
    self.r1img2URL=nil;
    self.r1img3URL=nil;
    
    
    
    //visual comments
    self.commentsCell.gutterImgView.tag=100;
    self.commentsCell.windowImgView.tag=101;
    self.commentsCell.wallsImgView.tag=102;
    self.commentsCell.roofTileimgView.tag=103;
    self.commentsCell.fencingImgView.tag=104;
    self.commentsCell.gatesImgView.tag=105;
    self.commentsCell.gardenImgView.tag=106;
    self.commentsCell.commAreaImgView.tag=107;
    self.commentsCell.smokeDetectorImgView.tag=108;
    //submit button
    self.submitBtn.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    self.submitBtn.layer.cornerRadius=5.0f;
    
    
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 180, 640, 140) cornerRadius:15.0];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.cornerRadius=5.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.baseView.layer addSublayer:shapeLayer];
    /*
     if ([self.view isKindOfClass:[ViewController class]]) {
     [self.view.layer addSublayer:shapeLayer];
     
     }
     
     */
    [self getUserList];
    
    //self.titleArray=[[NSMutableArray alloc]initWithObjects:@"Cleanliness",@"Outstanding Repairs",@"General Comments",@"Future Visits",@"Insurance",@"Declaration",@"Inspection Date and Time",@"External-Basic Visual Comments (as appropriate)",@"Note Any Damage",@"Note Any Breakages",@"Final Words",nil];
    
    
    self.titleArray=[[NSMutableArray alloc]initWithObjects:@"External-Basic Visual Comments (as appropriate)",@"Cleanliness",@"Note Any Damage",@"Note Any Breakages",@"Outstanding Repairs",@"General Comments",@"Declaration",@"Future Visits",@"Insurance",@"Inspection Date and Time",@"Final Words",nil];
    
    
    
    self.radioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO", nil];
    
    self.commentsRadioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO",@"N/A", nil];
    self.repairsCell.repairTxt.delegate=self;
    //[self.futureVisitradioButton setSelected:YES];
    
    
    normalkeyboardtoolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [normalkeyboardtoolbar sizeToFit];
    normalkeyboardtoolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(keyboardHide)],
                                   nil];
    
    
    normalkeyboardtoolbar.barStyle=UIBarStyleDefault;
    
    self.propertyAddressTxt.inputAccessoryView = self.normalkeyboardtoolbar;
    self.prepairedByTxt.inputAccessoryView = self.normalkeyboardtoolbar;
    
    
    [self.normalkeyboardtoolbar setHidden:YES];
    
    self.propertyAddressTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    self.propertyAddressTxt.layer.borderWidth= 1.0f;
    
    self.prepairedByTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.prepairedByTxt.layer.borderWidth= 1.0f;
    
    //creating toolbar
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.toolbar.barStyle = UIBarStyleDefault;
    [self.toolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(UserPickerCancelClick:)];
    //[barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(UserPickerDoneClick:)];
    [barItems addObject:doneBtn];
    
    [self.toolbar setItems:barItems animated:YES];
    
    loggedInUserpickerVC=[[UIPickerView alloc] initWithFrame:CGRectZero];
    
    loggedInUserpickerVC.delegate = self;
    [loggedInUserpickerVC setShowsSelectionIndicator:YES];
    self.prepairedByTxt.inputView = loggedInUserpickerVC;
    
    self.prepairedByTxt.inputAccessoryView=self.toolbar;
    self.prepairedByTxt.text=[self.userArray objectAtIndex:0];
    
    
    /*
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(dismissKeyboard)];
     
     [self.view addGestureRecognizer:tap];
     */
    


}

-(void) badViewWillAppear {
    // your code
    self.radioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO", nil];
    self.commentsRadioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO",@"N/A", nil];
    
    self.futureVisitRbArray = [NSMutableArray new];
    self.finalwordsRbArray = [NSMutableArray new];
    self.finalwordsRbArray2 = [NSMutableArray new];
    self.insuranceRbArray = [NSMutableArray new];
    
    //radio button array for visual comments cell
    self.gutterRbArray = [NSMutableArray new];
    self.windowsRbArray=[NSMutableArray new];
    self.wallsRbArray=[NSMutableArray new];
    self.roofRbArray=[NSMutableArray new];
    self.fencingRbArray=[NSMutableArray new];
    self.gatesRbArray=[NSMutableArray new];
    self.gardenRbArray=[NSMutableArray new];
    self.comAreaRbArray=[NSMutableArray new];
    self.smokeDetectorRbArray=[NSMutableArray new];
    
    
    
    
    //future visits radio button
    for (int i = 0; i < 2; i ++) {
        //CarImages *carObj = (CarImages*)[weakself.carArray objectAtIndex:i];
        UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [radioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [radioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [radioButton setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:i]] forState:UIControlStateNormal];
        [radioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        radioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (i)
        {
            [radioButton setFrame:CGRectMake(90, 60, 200, 44)];
            
            
        }
        else{
            [radioButton setFrame:CGRectMake(-10, 60, 200, 44)];
            [radioButton setSelected:YES];
        }
        
        
        [radioButton addTarget:self action:@selector(radioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.futureVisitRbArray addObject:radioButton];
        radioButton.tag=i;
        
        
        //final words radio button 1
        for (int j = 0; j < 2; j ++) {
            
            UIButton *finalradioButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [finalradioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [finalradioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
            [finalradioButton setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:j]] forState:UIControlStateNormal];
            [finalradioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            finalradioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
            if (j)
            {
                
                [finalradioButton setFrame:CGRectMake(580, 23, 200, 44)];
                
                
            }
            else{
                [finalradioButton setFrame:CGRectMake(490, 23, 200, 44)];
                [finalradioButton setSelected:YES];
            }
            
            [finalradioButton addTarget:self action:@selector(finalradioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.finalwordsRbArray addObject:finalradioButton];
            finalradioButton.tag=j;
        }
    }
    
    
    
    
    //final words radio button 2
    for (int k = 0; k < 2; k ++) {
        
        UIButton *finalradioButtontwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [finalradioButtontwo setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [finalradioButtontwo setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [finalradioButtontwo setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:k]] forState:UIControlStateNormal];
        [finalradioButtontwo setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        finalradioButtontwo.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        if (k)
        {
            
            [finalradioButtontwo setFrame:CGRectMake(580, 75, 200, 44)];
            
            
        }
        else{
            [finalradioButtontwo setFrame:CGRectMake(490, 75, 200, 44)];
            [finalradioButtontwo setSelected:YES];
        }
        
        [finalradioButtontwo addTarget:self action:@selector(finalradioButtontwoPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.finalwordsRbArray2 addObject:finalradioButtontwo];
        finalradioButtontwo.tag=k;
    }
    
    
    
    
    //Insurance cell radio button
    for (int l = 0; l < 2; l ++) {
        
        UIButton *insuranceRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [insuranceRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [insuranceRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [insuranceRadioButton setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:l]] forState:UIControlStateNormal];
        [insuranceRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        insuranceRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (l)
        {
            
            [insuranceRadioButton setFrame:CGRectMake(90, 90, 200, 44)];
            
            
        }
        else{
            [insuranceRadioButton setFrame:CGRectMake(0, 90, 200, 44)];
            [insuranceRadioButton setSelected:YES];
        }
        
        [insuranceRadioButton addTarget:self action:@selector(insuranceRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.insuranceRbArray addObject:insuranceRadioButton];
        insuranceRadioButton.tag=l;
    }
    
    
    //Visual comments cell gutter radio button
    for (int g = 0; g < 3; g++) {
        
        UIButton *gutterRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [gutterRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [gutterRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [gutterRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:g]] forState:UIControlStateNormal];
        [gutterRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        gutterRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (g==0)
        {
            
            
            [gutterRadioButton setFrame:CGRectMake(VISUAL_X_1, 28, 80, 44)];
            [gutterRadioButton setSelected:YES];
            
            
        }
        else if(g==1)
        {
            [gutterRadioButton setFrame:CGRectMake(VISUAL_X_2, 28, 80, 44)];
            
            
        }
        else{
            [gutterRadioButton setFrame:CGRectMake(VISUAL_X_3, 28, 80, 44)];
            
            
        }
        
        [gutterRadioButton addTarget:self action:@selector(gutterRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.gutterRbArray addObject:gutterRadioButton];
        gutterRadioButton.tag=g;
    }
    
    
    
    
    
    //Visual comments cell windows radio button
    for (int w = 0; w < 3; w ++) {
        
        UIButton *windowRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [windowRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [windowRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [windowRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:w]] forState:UIControlStateNormal];
        [windowRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        windowRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (w==0)
        {
            
            [windowRadioButton setFrame:CGRectMake(VISUAL_X_1, 175, 80, 44)];
            [windowRadioButton setSelected:YES];
            
            
        }
        else if(w==1){
            [windowRadioButton setFrame:CGRectMake(VISUAL_X_2, 175, 80, 44)];
        }
        else{
            [windowRadioButton setFrame:CGRectMake(VISUAL_X_3, 175, 80, 44)];
            
        }
        
        [windowRadioButton addTarget:self action:@selector(windowRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.windowsRbArray addObject:windowRadioButton];
        windowRadioButton.tag=w;
    }
    
    
    //Visual comments cell walls radio button
    for (int wa = 0; wa < 3; wa ++) {
        
        UIButton *wallsRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wallsRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [wallsRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [wallsRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:wa]] forState:UIControlStateNormal];
        [wallsRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        wallsRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (wa==0)
        {
            
            [wallsRadioButton setFrame:CGRectMake(VISUAL_X_1, 335, 80, 44)];
            [wallsRadioButton setSelected:YES];
            
            
        }
        else if(wa==1){
            [wallsRadioButton setFrame:CGRectMake(VISUAL_X_2, 335, 80, 44)];
        }
        else{
            [wallsRadioButton setFrame:CGRectMake(VISUAL_X_3, 335, 80, 44)];
            
        }
        
        [wallsRadioButton addTarget:self action:@selector(wallsRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.wallsRbArray addObject:wallsRadioButton];
        wallsRadioButton.tag=wa;
    }
    
    
    //Visual comments cell roof/tiles radio button
    for (int r = 0; r < 3; r ++) {
        
        UIButton *roofRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [roofRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [roofRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [roofRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:r]] forState:UIControlStateNormal];
        [roofRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        roofRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (r==0)
        {
            
            [roofRadioButton setFrame:CGRectMake(VISUAL_X_1, 500, 80, 44)];
            [roofRadioButton setSelected:YES];
            
            
        }else if(r==1){
            [roofRadioButton setFrame:CGRectMake(VISUAL_X_2, 500, 80, 44)];
        }
        else{
            [roofRadioButton setFrame:CGRectMake(VISUAL_X_3, 500, 80, 44)];
            
        }
        
        [roofRadioButton addTarget:self action:@selector(roofRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.roofRbArray addObject:roofRadioButton];
        roofRadioButton.tag=r;
    }
    
    
    
    //Visual comments cell fencing radio button
    for (int f = 0; f < 3; f ++) {
        
        UIButton *fencingRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fencingRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [fencingRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [fencingRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:f]] forState:UIControlStateNormal];
        [fencingRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        fencingRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (f==0)
        {
            
            [fencingRadioButton setFrame:CGRectMake(VISUAL_X_1, 660, 80, 44)];
            [fencingRadioButton setSelected:YES];
            
            
        }
        else if (f==1){
            [fencingRadioButton setFrame:CGRectMake(VISUAL_X_2, 660, 80, 44)];
        }
        else{
            [fencingRadioButton setFrame:CGRectMake(VISUAL_X_3, 660, 80, 44)];
            
        }
        
        [fencingRadioButton addTarget:self action:@selector(fencingRadioButtoPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.fencingRbArray addObject:fencingRadioButton];
        fencingRadioButton.tag=f;
    }
    
    
    
    //Visual comments cell gates radio button
    for (int gt = 0; gt < 3; gt ++) {
        
        UIButton *gateRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [gateRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [gateRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [gateRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:gt]] forState:UIControlStateNormal];
        [gateRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        gateRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (gt==0)
        {
            
            [gateRadioButton setFrame:CGRectMake(VISUAL_X_1, 817, 80, 44)];
            [gateRadioButton setSelected:YES];
            
            
        }
        else if (gt==1) {
            [gateRadioButton setFrame:CGRectMake(VISUAL_X_2, 817, 80, 44)];
        }
        else{
            [gateRadioButton setFrame:CGRectMake(VISUAL_X_3, 817, 80, 44)];
            
        }
        
        [gateRadioButton addTarget:self action:@selector(gateRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.gatesRbArray addObject:gateRadioButton];
        gateRadioButton.tag=gt;
    }
    
    
    //Visual comments cell garden radio button
    for (int gr = 0; gr < 3; gr ++) {
        
        UIButton *gardenRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [gardenRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [gardenRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [gardenRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:gr]] forState:UIControlStateNormal];
        [gardenRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        gardenRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (gr==0)
        {
            
            [gardenRadioButton setFrame:CGRectMake(VISUAL_X_1, 990, 80, 44)];
            [gardenRadioButton setSelected:YES];
            
            
        }
        else if (gr==1){
            [gardenRadioButton setFrame:CGRectMake(VISUAL_X_2, 990, 80, 44)];
        }
        else{
            [gardenRadioButton setFrame:CGRectMake(VISUAL_X_3, 990, 80, 44)];
            
        }
        
        [gardenRadioButton addTarget:self action:@selector(gardenRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.gardenRbArray addObject:gardenRadioButton];
        gardenRadioButton.tag=gr;
    }
    
    
    
    //Visual comments cell comm. Area radio button
    for (int ca = 0; ca < 3; ca ++) {
        
        UIButton *comaAreaRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [comaAreaRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [comaAreaRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [comaAreaRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:ca]] forState:UIControlStateNormal];
        [comaAreaRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        comaAreaRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (ca==0)
        {
            
            [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_1, 1150, 80, 44)];
            [comaAreaRadioButton setSelected:YES];
            
            
        }else if (ca==1){
            [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_2, 1150, 80, 44)];
        }
        else{
            [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_3, 1150, 80, 44)];
            
        }
        
        [comaAreaRadioButton addTarget:self action:@selector(comAreaRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.comAreaRbArray addObject:comaAreaRadioButton];
        comaAreaRadioButton.tag=ca;
    }
    
    
    
    //Visual comments smoke detectors radio button
    
    for (int sd = 0; sd < 3; sd ++) {
        
        UIButton *smokeDetectorsRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [smokeDetectorsRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [smokeDetectorsRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [smokeDetectorsRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:sd]] forState:UIControlStateNormal];
        [smokeDetectorsRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        smokeDetectorsRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
        
        if (sd==0)
        {
            
            
            [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_1, 1318, 80, 44)];
            [smokeDetectorsRadioButton setSelected:YES];
            
            
        }
        else if(sd==1)
        {
            [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_2, 1318, 80, 44)];
            
            
        }
        else{
            [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_3, 1318, 80, 44)];
            
            
        }
        
        
        [smokeDetectorsRadioButton addTarget:self action:@selector(smokeDetectorsRadioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.smokeDetectorRbArray addObject:smokeDetectorsRadioButton];
        smokeDetectorsRadioButton.tag=sd;
    }

}


-(void) initVisualComments {
    
    if (self.commentsCell == nil){
        
        static NSString *commentIdentifier = @"VisualCommentsCell";
        [commentsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
        commentsCell = (VisualCommentsCell *)[self.tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VisualCommentsCell" owner:self options:nil];
        self.commentsCell = [nib objectAtIndex:0];
        
        
        rect=  CGRectMake(25, 15, 720, 1465);
        
        tempRefCell=self.commentsCell;
        [self createBorder];
        
        self.commentsCell.gutterTxt.layer.borderWidth = 1.0f;
        self.commentsCell.gutterTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        
        self.commentsCell.windowTxt.layer.borderWidth = 1.0f;
        self.commentsCell.windowTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.wallTxt.layer.borderWidth = 1.0f;
        self.commentsCell.wallTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.roofTileTxt.layer.borderWidth = 1.0f;
        self.commentsCell.roofTileTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.fencingTxt.layer.borderWidth = 1.0f;
        self.commentsCell.fencingTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.gatesTxt.layer.borderWidth = 1.0f;
        self.commentsCell.gatesTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.gardenTxt.layer.borderWidth = 1.0f;
        self.commentsCell.gardenTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        self.commentsCell.commAreaTxt.layer.borderWidth = 1.0f;
        self.commentsCell.commAreaTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        
        self.commentsCell.smokeDetectorTxt.layer.borderWidth = 1.0f;
        self.commentsCell.smokeDetectorTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
        
        [self.commentsCell addSubview:[gutterRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[gutterRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[gutterRbArray objectAtIndex:2]];
        
        
        [self.commentsCell addSubview:[windowsRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[windowsRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[windowsRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[wallsRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[wallsRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[wallsRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[roofRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[roofRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[roofRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[fencingRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[fencingRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[fencingRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[gatesRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[gatesRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[gatesRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[gardenRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[gardenRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[gardenRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:2]];
        
        [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:0]];
        [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:1]];
        [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:2]];
        
        self.commentsCell.gutterImgView.tag=100;
        self.commentsCell.windowImgView.tag=101;
        self.commentsCell.wallsImgView.tag=102;
        self.commentsCell.roofTileimgView.tag=103;
        self.commentsCell.fencingImgView.tag=104;
        self.commentsCell.gatesImgView.tag=105;
        self.commentsCell.gardenImgView.tag=106;
        self.commentsCell.commAreaImgView.tag=107;
        self.commentsCell.smokeDetectorImgView.tag=108;
        
        [self.commentsCell.gutterImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.windowImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        
        [self.commentsCell.wallsImgView addTarget: self action: @selector(pickImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.commentsCell.roofTileimgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.fencingImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.gatesImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.gardenImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.commAreaImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        [self.commentsCell.smokeDetectorImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
        
    }
}



#pragma mark UITableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //CarImages *carObj = (CarImages*)[self.carArray objectAtIndex:indexPath.section];
    
    BOOL isChild =
    currentExpandedIndex > -1
    && indexPath.row > currentExpandedIndex
    && indexPath.row <= currentExpandedIndex + 1;
    
    int currentIndex;
    
    if (isChild)
    {
        currentIndex = indexPath.row - 1;
        
        if (currentIndex==0){
            return 1500;
            
        } else if (currentIndex==1){
            return 270; //cleanliness
            
        } else if (currentIndex==2){
            return 200; //note damage
        } else if (currentIndex==3){
            return 200; //note breakage
            
        } else if (currentIndex==4){
            return 200; //outstanding repair
        } else if (currentIndex==5){
            return 200; //general comments
        } else if (currentIndex==6){
            return 350; //declaration
            
        } else if (currentIndex==7){
            return 150; // future visits
            
        } else if (currentIndex==8){
            return 200; //insurance
            
        } else if (currentIndex==9){
            return 150; //inspection date and time
            
        } else if (currentIndex==10){
            return 140; //final words
        }
        return 1;
        
    }
    else
    {
        
        if(currentExpandedIndex > -1 && indexPath.row > currentExpandedIndex)
            currentIndex = indexPath.row-1;
        else
            currentIndex = indexPath.row;
        
        return 60;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    BOOL isChild =
    currentExpandedIndex > -1
    && indexPath.row > currentExpandedIndex
    && indexPath.row <= currentExpandedIndex + 1;
    
    
    if (isChild)
    {
        
        if (currentExpandedIndex==0)
            
        {
            
            if (self.commentsCell == nil) {
                static NSString *commentIdentifier = @"VisualCommentsCell";
                [commentsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                commentsCell = (VisualCommentsCell *)[self.tableView dequeueReusableCellWithIdentifier:commentIdentifier];
                //{
                
                // self.commentsCell = [[VisualCommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentIdentifier];
                
                
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VisualCommentsCell" owner:self options:nil];
                self.commentsCell = [nib objectAtIndex:0];
                // }
                
                rect=  CGRectMake(25, 15, 720, 1465);
                
                tempRefCell=self.commentsCell;
                [self createBorder];
                
                self.commentsCell.gutterTxt.layer.borderWidth = 1.0f;
                self.commentsCell.gutterTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                self.commentsCell.windowTxt.layer.borderWidth = 1.0f;
                self.commentsCell.windowTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.wallTxt.layer.borderWidth = 1.0f;
                self.commentsCell.wallTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.roofTileTxt.layer.borderWidth = 1.0f;
                self.commentsCell.roofTileTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.fencingTxt.layer.borderWidth = 1.0f;
                self.commentsCell.fencingTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.gatesTxt.layer.borderWidth = 1.0f;
                self.commentsCell.gatesTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.gardenTxt.layer.borderWidth = 1.0f;
                self.commentsCell.gardenTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                self.commentsCell.commAreaTxt.layer.borderWidth = 1.0f;
                self.commentsCell.commAreaTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                self.commentsCell.smokeDetectorTxt.layer.borderWidth = 1.0f;
                self.commentsCell.smokeDetectorTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                [self.commentsCell addSubview:[gutterRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[gutterRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[gutterRbArray objectAtIndex:2]];
                
                
                [self.commentsCell addSubview:[windowsRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[windowsRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[windowsRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[wallsRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[wallsRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[wallsRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[roofRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[roofRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[roofRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[fencingRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[fencingRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[fencingRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[gatesRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[gatesRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[gatesRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[gardenRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[gardenRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[gardenRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:2]];
                
                [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:0]];
                [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:1]];
                [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:2]];
                
                self.commentsCell.gutterImgView.tag=100;
                self.commentsCell.windowImgView.tag=101;
                self.commentsCell.wallsImgView.tag=102;
                self.commentsCell.roofTileimgView.tag=103;
                self.commentsCell.fencingImgView.tag=104;
                self.commentsCell.gatesImgView.tag=105;
                self.commentsCell.gardenImgView.tag=106;
                self.commentsCell.commAreaImgView.tag=107;
                self.commentsCell.smokeDetectorImgView.tag=108;
                
                [self.commentsCell.gutterImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.windowImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                
                [self.commentsCell.wallsImgView addTarget: self action: @selector(pickImage:) forControlEvents:UIControlEventTouchUpInside];
                [self.commentsCell.roofTileimgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.fencingImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.gatesImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.gardenImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.commAreaImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                [self.commentsCell.smokeDetectorImgView addTarget: self action: @selector(pickImage:) forControlEvents: UIControlEventTouchUpInside];
                
            }
            return commentsCell;
            
            
        }
        
        if (currentExpandedIndex==1)
            
        {
            if (self.cleanlinessCell == nil)
            {
                self.cleanlinessCell=[[CleanlinessCell alloc]init];
                self.cleanlinessCell.scrollView.delegate = self;
                
                static NSString *cleanlinessIdentifier = @"CleanlinessCell";
                [cleanlinessCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                cleanlinessCell = (CleanlinessCell *)[self.tableView dequeueReusableCellWithIdentifier:cleanlinessIdentifier];
                
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CleanlinessCell" owner:self options:nil];
                self.cleanlinessCell = [nib objectAtIndex:0];
                
                
                
                UIButton *addnewcleanlinessBlock = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [addnewcleanlinessBlock addTarget:self
                                           action:@selector(insertNewCleanlinessBlock:)
                                 forControlEvents:UIControlEventTouchUpInside];
                [addnewcleanlinessBlock setTitle:@"[+ Add more]" forState:UIControlStateNormal];
                addnewcleanlinessBlock.frame = CGRectMake(5.0, 230.0, 160.0, 40.0);
                
                [self.cleanlinessCell addSubview:addnewcleanlinessBlock];
                
                
                self.cleanlinessScrollView = self.cleanlinessCell.scrollView;
                self.cleanlinessCell.scrollView.delegate=self;
                // [self.cleanlinessCell.contentView addSubview:self.cleanlinessCell.scrollView];
                [self insertNewCleanlinessBlock:nil];
                self.cleanlinessScrollView.pagingEnabled = YES;
                
                
                
                pageControl = [[UIPageControl alloc] init];
                
                pageControl.frame = CGRectMake(((self.cleanlinessCell.frame.size.width - 5.0) / 2),245,10,5);
                pageControl.numberOfPages = self.page;
                pageControl.currentPage = 0;
                [self.cleanlinessCell addSubview:pageControl];
                
                [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
                [pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
                //pageControl.backgroundColor = [UIColor orangeColor];
                
                
            }
            return self.cleanlinessCell;
            
        }
        
        
        if (currentExpandedIndex==2)
            
        {
            
            if (self.noteDamageCell == nil) {
                static NSString *damageIdentifier = @"NoteDamageCell";
                [noteDamageCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                noteDamageCell = (NoteDamageCell *)[self.tableView dequeueReusableCellWithIdentifier:damageIdentifier];
                //{
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteDamageCell" owner:self options:nil];
                self.noteDamageCell = [nib objectAtIndex:0];
                //}
                
                self.noteDamageCell.noteDamageTxt.layer.borderWidth = 1.0f;
                self.noteDamageCell.noteDamageTxt.layer.cornerRadius=8.0f;
                self.noteDamageCell.noteDamageTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            }
            return noteDamageCell;
            
        }
        
        
        if (currentExpandedIndex==3)
            
        {
            if (self.noteBreakageCell == nil)
            {
                
                static NSString *breakageIdentifier = @"NoteBreakageCell";
                [noteBreakageCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                noteBreakageCell = (NoteBreakageCell *)[self.tableView dequeueReusableCellWithIdentifier:breakageIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteBreakageCell" owner:self options:nil];
                self.noteBreakageCell = [nib objectAtIndex:0];
                
                self.noteBreakageCell.breakageTxt.layer.borderWidth = 1.0f;
                self.noteBreakageCell.breakageTxt.layer.cornerRadius=8.0f;
                self.noteBreakageCell.breakageTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            }
            return noteBreakageCell;
            
        }
        
        
        if (currentExpandedIndex==4)
            
        {
            
            
            if (self.repairsCell == nil)
            {
                static NSString *repairIdentifier = @"RepairsCell";
                [repairsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                repairsCell = (RepairsCell *)[self.tableView dequeueReusableCellWithIdentifier:repairIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RepairsCell" owner:self options:nil];
                self.repairsCell = [nib objectAtIndex:0];
                
                normalkeyboardtoolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
                self.outstandingRepairTxt=self.repairsCell.repairTxt.text;
                self.repairsCell.repairTxt.layer.borderWidth = 1.0f;
                self.repairsCell.repairTxt.layer.cornerRadius=8.0f;
                self.repairsCell.repairTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            }
            return repairsCell;
            
        }
        
        
        if (currentExpandedIndex==5)
            
        {
            
            
            if (self.generalCommentsCell == nil)
            {
                static NSString *generalIdentifier = @"GeneralCommentsCell";
                [generalCommentsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                generalCommentsCell = (GeneralCommentsCell *)[self.tableView dequeueReusableCellWithIdentifier:generalIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GeneralCommentsCell" owner:self options:nil];
                self.generalCommentsCell = [nib objectAtIndex:0];
                
                self.generalCommentsCell.generalCommentsTxt.layer.borderWidth = 1.0f;
                self.generalCommentsCell.generalCommentsTxt.layer.cornerRadius=8.0f;
                self.generalCommentsCell.generalCommentsTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                [self createToolBar];
            }
            
            return generalCommentsCell;
            
        }
        
        if (currentExpandedIndex==6)
            
        {
            if (self.declarationCell == nil)
            {
                static NSString *declareIdentifier = @"DeclarationCell";
                [declarationCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                declarationCell = (DeclarationCell *)[self.tableView dequeueReusableCellWithIdentifier:declareIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeclarationCell" owner:self options:nil];
                self.declarationCell = [nib objectAtIndex:0];
                
                
                NSDate *currDate = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                // [dateFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
                [dateFormatter setDateFormat:@"dd/MM/YYYY"];
                NSString *dateString = [dateFormatter stringFromDate:currDate];
                NSLog(@"dateString:%@",dateString);
                
                self.declarationCell.declarationDateTxt.text=dateString;
                self.declarationCell.declarationDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.declarationCell.declarationDateTxt.layer.borderWidth= 1.0f;
                
                
                self.declarationCell.teenantSignatureTxt.layer.borderWidth = 1.0f;
                self.declarationCell.teenantSignatureTxt.layer.borderColor = [    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                
                self.declarationCell.behalfTxt.layer.borderWidth = 1.0f;
                self.declarationCell.behalfTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                rect=  CGRectMake(30, 25, 705, 300);
                
                tempRefCell=self.declarationCell;
                [self createBorder];
            }
            return declarationCell;
            
            
        }
        
        if (currentExpandedIndex==7)
            
        {
            if (self.futureVisitCell == nil)
            {
                static NSString *futureIdentifier = @"FutureVisitsCell";
                [futureVisitCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                futureVisitCell = (FutureVisitsCell *)[self.tableView dequeueReusableCellWithIdentifier:futureIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FutureVisitsCell" owner:self options:nil];
                self.futureVisitCell = [nib objectAtIndex:0];
                
                
                
                [self.futureVisitCell addSubview:[futureVisitRbArray objectAtIndex:0]];
                [self.futureVisitCell addSubview:[futureVisitRbArray objectAtIndex:1]];
                //[self.futureVisitCell.futureVisitsRadioBtn addTarget:self action:@selector(futureRadioBtn:) forControlEvents:UIControlEventTouchUpInside];
                self.futureVisitCell.futureDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.futureVisitCell.futureDateTxt.layer.borderWidth= 1.0f;
                
                rect=  CGRectMake(50, 15, 660, 120);
                tempRefCell=self.futureVisitCell;
                [self createBorder];
            }
            return futureVisitCell;
            
            
        }
        
        
        if (currentExpandedIndex==8)
            
        {
            if (self.insuranceCell == nil)
            {
                static NSString *insuranceIdentifier = @"InsuranceCell";
                [insuranceCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                insuranceCell = (InsuranceCell *)[self.tableView dequeueReusableCellWithIdentifier:insuranceIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InsuranceCell" owner:self options:nil];
                self.insuranceCell = [nib objectAtIndex:0];
                
                
                self.insuranceCell.policyNoTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.insuranceCell.policyNoTxt.layer.borderWidth= 1.0f;
                rect=  CGRectMake(55, 20, 670, 160);
                tempRefCell=self.insuranceCell;
                [self createBorder];
                self.insuranceCell.insranceDetailTxtView.layer.borderWidth = 1.0f;
                
                self.insuranceCell.insranceDetailTxtView.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
                
                
                [self.insuranceCell addSubview:[insuranceRbArray objectAtIndex:0]];
                [self.insuranceCell addSubview:[insuranceRbArray objectAtIndex:1]];
                
            }
            return insuranceCell;
            
        }
        
        if (currentExpandedIndex==9)
            
        {
            if (self.inspectionCell == nil)
            {
                static NSString *inspectionIdentifier = @"InspectionCell";
                [inspectionCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                inspectionCell = (InspectionCell *)[self.tableView dequeueReusableCellWithIdentifier:inspectionIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InspectionCell" owner:self options:nil];
                self.inspectionCell = [nib objectAtIndex:0];
                
                NSDate *currDate = [NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                // [dateFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
                [dateFormatter setDateFormat:@"dd/MM/YYYY"];
                NSString *dateString = [dateFormatter stringFromDate:currDate];
                NSLog(@"dateString:%@",dateString);
                
                self.inspectionCell.inspectionDateTxt.text=dateString;
                
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                
                
                self.inspectionCell.inspectionDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.inspectionCell.inspectionDateTxt.layer.borderWidth= 1.0f;
                
                self.inspectionCell.inspectionTimeTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.inspectionCell.inspectionTimeTxt.layer.borderWidth= 1.0f;
                
                self.inspectionCell.presentTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
                self.inspectionCell.presentTxt.layer.borderWidth= 1.0f;
                
                rect=  CGRectMake(20, 15, 725, 120);
                
                tempRefCell=self.inspectionCell;
                [self createBorder];
            }
            return inspectionCell;
            
            
        }
        
        if (currentExpandedIndex==10)
            
        {
            if (self.finalCell == nil)
            {
                static NSString *finalIdentifier = @"FinalWordsCell";
                [finalCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
                finalCell = (FinalWordsCell *)[self.tableView dequeueReusableCellWithIdentifier:finalIdentifier];
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FinalWordsCell" owner:self options:nil];
                self.finalCell = [nib objectAtIndex:0];
                
                [self.finalCell addSubview:[finalwordsRbArray objectAtIndex:0]];
                [self.finalCell addSubview:[finalwordsRbArray objectAtIndex:1]];
                
                [self.finalCell addSubview:[finalwordsRbArray2 objectAtIndex:0]];
                [self.finalCell addSubview:[finalwordsRbArray2 objectAtIndex:1]];
                
                rect=  CGRectMake(30, 20, 710, 100);
                
                tempRefCell=self.finalCell;
                [self createBorder];
            }
            return finalCell;
            
        }
        
    }
    else{
        
        static NSString *ChildCellIdentifier = @"HeaderCell";
        
        self.headerCell=(HeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:ChildCellIdentifier];
        
        if (self.headerCell==nil) {
            
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HeaderCell" owner:self options:nil];
            self.headerCell=[nib objectAtIndex:0];
            
        }
        
        int topIndex = (currentExpandedIndex > -1 && indexPath.row > currentExpandedIndex)
        ? indexPath.row - 1
        : indexPath.row;
        
        self.headerCell.headerTitleLbl.text=[self.titleArray objectAtIndex:topIndex];
        
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f]]; // blue color
        
        [self.headerCell setSelectedBackgroundView:bgColorView];
        //[self.headerCell.headerTitleLbl setTextColor:[UIColor whiteColor]];
        self.headerCell.headerTitleLbl.textColor=[UIColor blackColor];
        
        self.headerCell.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0]; //grey color
        
        return headerCell;
        
    }
    
    return headerCell;
    return cleanlinessCell;
    return repairsCell;
    return generalCommentsCell;
    return futureVisitCell;
    return insuranceCell;
    return declarationCell;
    return inspectionCell;
    return commentsCell;
    return noteDamageCell;
    return noteBreakageCell;
    return finalCell;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // return 12 + ((currentExpandedIndex > -1) ? 1 : 0);
    return titleArray.count+ ((currentExpandedIndex > -1) ? 1 : 0);
    // return 12;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ini_viewXposition=0.0;
    BOOL isChild =
    currentExpandedIndex > -1
    && indexPath.row > currentExpandedIndex
    && indexPath.row <= currentExpandedIndex + 1;
    
    if (isChild) {
        NSLog(@"A child was tapped, do what you will with it");
        return;
    }
    else{
        
        HeaderCell *selectedCell=[self.tableView cellForRowAtIndexPath:indexPath];
        
        // perform required operation
        UILabel * label =selectedCell.headerTitleLbl;
        // [label setTextColor:[UIColor whiteColor]];
        //[self.headerCell.headerTitleLbl setTextColor:[UIColor whiteColor]];
    }
    
    [self.tableView beginUpdates];
    [self.headerCell.headerTitleLbl setTextColor:[UIColor blackColor]];
    
    if (currentExpandedIndex == indexPath.row) {
        [self collapseSubItemsAtIndex:currentExpandedIndex];
        currentExpandedIndex = -1;
    }
    else {
        
        BOOL shouldCollapse = currentExpandedIndex > -1;
        
        if (shouldCollapse) {
            [self collapseSubItemsAtIndex:currentExpandedIndex];
            [self.headerCell.headerTitleLbl setTextColor:[UIColor blackColor]];
        }
        
        currentExpandedIndex = (shouldCollapse && indexPath.row > currentExpandedIndex) ? indexPath.row - 1 : indexPath.row;
        
        [self expandItemAtIndex:currentExpandedIndex];
        
    }
    
    
    [self.tableView endUpdates];
}

@end









































































































/*
 -(void)postDataToServer{
 
 NSString *aptURL=[NSString stringWithFormat:@"http://182.93.95.189/SmartHub/api/values"];
 NSString *fixedURL = [aptURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 //NSURL *url = [NSURL URLWithString:fixedURL];
 
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 //
 //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
 //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 //
 manager.requestSerializer = [AFJSONRequestSerializer serializer];
 manager.responseSerializer = [AFJSONResponseSerializer serializer];
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 
 
 
 manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
 
 //[manager.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
 
 NSDictionary *params = @{@"PreparedBy": @"hello", @"PropertyAddress":@"kathmandu Nepal", @"company":@"my test company"};
 
 [manager POST:fixedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //NSLog(@"JSON: %@", responseObject);
 NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
 NSLog(@"dataDictionary:%@",dataDictionary);
 
 
 } failure:
 ^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"Error is::: %@", error); }];
 
 
 
 
 
 
 
 
 NSURLRequest *aptrequest = [NSURLRequest requestWithURL:url];
 //__block __typeof(self) __weak weakself = self;
 
 // 2
 submitRequest = [[AFHTTPRequestOperation alloc] initWithRequest:aptrequest];
 submitRequest.responseSerializer = [AFJSONResponseSerializer serializer];
 submitRequest.responseSerializer = [AFHTTPResponseSerializer serializer];
 submitRequest.responseSerializer.acceptableContentTypes = [submitRequest.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
 [submitRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
 
 
 {
 NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
 NSLog(@"dataDictionary:%@",dataDictionary);
 
 //NSLog(@"dict:%@",dict);
 
 
 if ([[dataDictionary valueForKey:@"success"] boolValue])
 {
 NSMutableArray *jsonArray=[dataDictionary valueForKey:@"data"];
 
 }
 else
 {
 
 UIAlertView *failedAlert = [[UIAlertView alloc] initWithTitle:@"Error!"
 message:[dataDictionary valueForKey:@"message"]
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil];
 [failedAlert show];
 
 
 }
 
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 // 4
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
 message:[error localizedDescription]
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil];
 [alertView show];
 
 }];
 
 // 5
 [submitRequest start];
 
 
 }
 
 
 
 
 */





/*
 
 -(void)check{
 // NSMutableArray *arrayOfDicts = [[NSMutableArray alloc] init];
 /*
 NSDictionary *myDictForJSON = @{
 @"Company" : @"my company",
 @"PropertyAddress" : @"kathmandu",
 @"PreparedBy" : @"customer6@xy.com",
 @"Groups":@[@{
 @"groupName":@"Outstanding Repairs",
 @"displayOrder":@"1",
 @"fieldgroups":@[@{
 @"fieldName":@"Repair_note",
 @"displayLabel":@"Repair note",
 @"dataType":@"string",
 @"isRequired":@"true",
 @"value":@"this is the repair text to post..",
 @"displayOrder":@"0"
 
 }]}]};
 
 */

/*
 NSDictionary *jsonDict = @{
 @"Company" : @"company",
 @"PropertyAddress" : @"kathmandu",
 @"PreparedBy" : @"customer",
 // @"groups":@[@{
 
 @"GroupName":@"Cleanliness",
 @"DisplayOrder":@"0",
 @"FieldGroups":@[@{
 @"Fields":@[@{
 @"FieldName":@"Floors",
 @"DisplayLabel":@"Floors",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"yes",
 @"DisplayOrder": @"0"
 
 }]
 }]
 
 
 //}]
 
 };
 
 /*
 NSDictionary *myDictForJSON = @{
 @"company" : @"my company",
 @"propertyAddress" : @"kathmandu",
 @"preparedBy" : @"customer",
 @"formFields":@{
 @"groups":@[@{
 @"groupName":@"Cleanliness",
 @"displayOrder":@"0",
 @"fieldGroups":@[@{
 @"fields":@[@{
 
 @"fieldName":@"Floors",
 @"displayLabel":@"Floors",
 @"dataType": @"string",
 @"isRequired": @"true",
 @"value":@"yes",
 @"displayOrder": @"0"
 },
 
 @{
 
 @"fieldName":@"Comments",
 @"displayLabel":@"Comments",
 @"dataType": @"textarea",
 @"isRequired": @"true",
 @"value":@"this is comment text",
 @"displayOrder": @"1"
 },
 @{
 @"fieldName": @"image",
 @"displayLabel": @"Add Image",
 @"dataType": @"image",
 @"isRequired": @true,
 @"value": [UIImage imageNamed:@"asda.jpg"],
 @"displayOrder": @"2"}
 
 ]
 
 }]
 
 
 
 }]
 }
 };
 
 */

/*
 
 @"formFields":@{
 @"groups":@[@{
 @"groupName":@"Cleanliness",
 @"displayOrder":@"0",
 @"fieldGroups":@[@{
 
 @"fieldName":@"Repair_note",
 @"displayLabel":@"Repair note",
 @"dataType":@"string",
 @"isRequired":@"true",
 @"value":@"this is the repaire text to post..",
 @"displayOrder":@"0"
 
 }]}]}
 */

/*
 NSDictionary *jsonDict = @{
 @"Company" : @"Verisk",
 @"PropertyAddress" : @"kathmandu",
 @"PreparedBy" : @"krishna",
 @"Groups":@[@{
 
 @"GroupName":@"Cleanliness",
 @"DisplayOrder":@"0",
 @"FieldGroups":@[@{
 @"Fields":@[@{
 @"FieldName":@"Floors",
 @"DisplayLabel":@"Floors",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"yes",
 @"DisplayOrder": @"0"
 
 },
 
 @{
 @"FieldName":@"Walls",
 @"DisplayLabel":@"Walls",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"yes",
 @"DisplayOrder": @"1"
 
 },
 @{
 @"FieldName":@"Windows",
 @"DisplayLabel":@"Windows",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"yes",
 @"DisplayOrder": @"2"
 
 },
 @{
 @"FieldName":@"Curtains",
 @"DisplayLabel":@"Curtains",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"no",
 @"DisplayOrder": @"3"
 
 },
 
 @{
 @"FieldName":@"Furnishing",
 @"DisplayLabel":@"Furnishing",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"no",
 @"DisplayOrder": @"4"
 
 }
 ]
 }]
 
 
 
 }]
 
 };
 
 */

/*
 NSDictionary *jsonDict = @{
 @"Company" : @"Verisk",
 @"PropertyAddress" : @"kathmandu",
 @"PreparedBy" : @"krishna",
 @"Groups":@[@{
 
 @"GroupName":@"Cleanliness",
 @"DisplayOrder":@"0",
 @"FieldGroups":@[@{
 @"Fields":@[@{
 @"FieldName":@"Floors",
 @"DisplayLabel":@"Floors",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"yes",
 @"DisplayOrder": @"0"
 
 },
 
 @{
 @"FieldName":@"Comments",
 @"DisplayLabel":@"Comments",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value":@"this is comment",
 @"DisplayOrder": @"1"
 
 },
 @{
 @"FieldName":@"image",
 @"DisplayLabel":@"Add Image",
 @"DataType": @"image",
 @"IsRequired": @"true",
 @"Value":@"http://res.cloudinary.com/dym11jnwp/image/upload/v1413557357/xnbus1tqdncuggwcqizq.jpg",
 @"DisplayOrder": @"2"
 
 },
 @{
 @"FieldName":@"isFutureVisit",
 @"DisplayLabel":@"Future Visits",
 @"DataType": @"boolen",
 @"IsRequired": @"true",
 @"Value":@"0",
 @"DisplayOrder": @"3"
 
 },
 
 @{
 @"FieldName":@"Date",
 @"DisplayLabel":@"Date",
 @"DataType": @"datetime",
 @"IsRequired": @"true",
 @"Value":@"",
 @"DisplayOrder": @"4"
 
 }
 ]
 }]
 
 
 
 }]
 
 };
 */
/*
 NSDictionary *jsonDict =  @{
 @"Company": @"ABC company",
 @"PropertyAddress": @"kathmandu , Nepal",
 @"PreparedBy": @"Test user",
 @"Groups": @[
 @{
 @"GroupName": @"Cleanliness",
 @"DisplayOrder": @"0",
 @"FieldGroups": @[
 @{
 @"Fields": @[
 @{
 @"FieldName": @"Floors",
 @"DisplayLabel": @"Floors",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value": @"3",
 @"DisplayOrder": @"0"
 },
 @{
 @"FieldName": @"Comments",
 @"DisplayLabel": @"Comments",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value": @"No comments whatsoever",
 @"DisplayOrder": @"1"
 },
 @{
 @"FieldName": @"image",
 @"DisplayLabel": @"Add Image",
 @"DataType": @"image",
 @"IsRequired": @"true",
 @"Value":@"http://res.cloudinary.com/wisethapa/image/upload/c_scale,w_191/v1413172916/cute_cat.jpg",
 @"DisplayOrder": @"2"
 },
 @{
 @"FieldName": @"isFutureVisit",
 @"DisplayLabel": @"Future Visits",
 @"DataType": @"boolen",
 @"IsRequired": @"true",
 @"Value": @"0",
 @"DisplayOrder": @"3"
 },
 @{
 @"FieldName": @"Date",
 @"DisplayLabel": @"Date",
 @"DataType": @"datetime",
 @"IsRequired": @"true",
 @"Value": @"",
 @"DisplayOrder": @"4"
 }
 ],
 @"DisplayOrder": @"0"
 },
 @{
 @"Fields": @[
 @{
 @"FieldName": @"Floors",
 @"DisplayLabel": @"Floors",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value": @"3",
 @"DisplayOrder": @"0"
 },
 @{
 @"FieldName": @"Comments",
 @"DisplayLabel": @"Comments",
 @"DataType": @"textarea",
 @"IsRequired": @"true",
 @"Value": @"None whatsoever",
 @"DisplayOrder": @"1"
 },
 @{
 @"FieldName": @"image",
 @"DisplayLabel": @"Add Image",
 @"DataType": @"image",
 @"IsRequired": @"true",
 @"Value":@"http://res.cloudinary.com/wisethapa/image/upload/c_scale,w_200/v1413172916/cute_cat.jpg",
 @"DisplayOrder": @"2"
 },
 @{
 @"FieldName": @"isFutureVisit",
 @"DisplayLabel": @"Future Visits",
 @"DataType": @"boolen",
 @"IsRequired": @"true",
 @"Value": @"1",
 @"DisplayOrder": @"3"
 },
 @{
 @"FieldName": @"Date",
 @"DisplayLabel": @"Date",
 @"DataType": @"datetime",
 @"IsRequired": @"true",
 @"Value": @"",
 @"DisplayOrder": @"4"
 }
 ],
 @"DisplayOrder": @"0"
 }
 ]
 },
 @{
 @"GroupName": @"Outstanding Repairs",
 @"DisplayOrder": @"1",
 @"FieldGroups": @[
 @{
 @"Fields": @[
 @{
 @"FieldName": @"Repair_note",
 @"DisplayLabel": @"Repair note",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value": @"This thing needs to be repaired ASAP",
 @"DisplayOrder": @"0"
 }
 ]
 }
 ]
 },
 @{
 @"GroupName": @"General Comments",
 @"DisplayOrder": @"2",
 @"FieldGroups": @[
 @{
 @"Fields": @[
 @{
 @"FieldName": @"Comment",
 @"DisplayLabel": @"Comment",
 @"DataType": @"string",
 @"IsRequired": @"true",
 @"Value": @"Some general comment here",
 @"DisplayOrder": @"0"
 }
 ]
 }
 ]
 }
 ]
 };
 
 
 
 
 //[arrayOfDicts addObject:jsonDictionary];
 NSError *error;
 //NSArray *info = [NSArray arrayWithArray:arrayOfDicts];
 
 
 
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
 options:NSJSONWritingPrettyPrinted error:&error];
 NSLog(@"jsondata:%@",jsonData);
 NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
 
 NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/SmartHub/api/property/"];
 
 NSString *fixedURL = [URL
 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
 NSURL *url = [NSURL URLWithString:fixedURL];
 
 ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
 NSLog(@"::::%@",jsonString);
 
 [request setRequestMethod:@"POST"];
 ///[request addRequestHeader:@"Accept" value:@"http://182.93.95.189/SmartHub/api/property/"];
 [request addRequestHeader:@"Accept" value:@"application/json"];
 //[request addRequestHeader:@"content-type" value:[NSString stringWithFormat:@"%@",jsonString]];
 [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
 // [request addRequestHeader:@"User-Agent" value:@"iPad"];
 NSLog(@"data:::%@",[NSMutableData dataWithData:jsonData]);
 [request setPostBody:[NSMutableData dataWithData:jsonData]];
 //[request setPostBody:jsonString];
 
 //    NSMutableData *requestBody = [[NSMutableData alloc] initWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
 //    [request setRequestMethod:@"POST"];
 //    [request setPostBody:requestBody];
 //    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
 //
 
 
 
 
 //  NSData *imgData=[[NSData alloc]init];
 
 //imgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(([UIImage imageNamed:@"cutain1.jpg"]), 1)];
 //[request setData:imgData withFileName:@"sample" andContentType:@"image/jpeg" forKey:@"client_image"];
 [request setDelegate:self];
 [request startAsynchronous];
 
 
 }
 
 
 
 
 */

