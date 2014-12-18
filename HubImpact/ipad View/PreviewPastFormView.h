//
//  PreviewPastFormView.h
//  HubImpact
//
//  Created by Prakash Maharjan on 29/10/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "SBJSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
//#import "MBProgressHUD.h"
@class PreviousFormCell;
//@class MBProgressHUD;


@interface PreviewPastFormView : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate,UIToolbarDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) PreviousFormCell *previousCell;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)doSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *keywordTxtfield;
@property(nonatomic,strong) ASIFormDataRequest *searchrequest;

@property(nonatomic,strong) UIDatePicker *datepickerView;
@property(nonatomic,strong) UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UITextField *fromDatetxtfield;
@property (weak, nonatomic) IBOutlet UITextField *toDatetxtfield;
@property (weak, nonatomic) IBOutlet UITextField *formTypetxtfield;
@property (weak, nonatomic) IBOutlet UITextField *sortOrderTxtfield;

@property(nonatomic,strong) IBOutlet UIPickerView *sortOrderPickerView;
@property(nonatomic,strong) NSMutableArray *sortOptionsArray;

@property(nonatomic,strong) IBOutlet UIPickerView *typePickerView;
@property(nonatomic,strong) NSMutableArray *typeArray;
@property(nonatomic,strong) NSMutableArray *mainArray;
@property(nonatomic,strong) NSMutableArray *responseArray;
@property(nonatomic,strong) NSMutableArray *mainDict;


- (IBAction)move:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
//@property(nonatomic,strong) MBProgressHUD *hud;
@property(nonatomic,strong) NSString *accessToken;
@property(nonatomic,strong) NSString *userName;

- (IBAction)LogOutBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@end
