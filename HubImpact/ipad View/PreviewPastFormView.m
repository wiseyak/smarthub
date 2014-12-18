//
//  PreviewPastFormView.m
//  HubImpact
//
//  Created by Prakash Maharjan on 29/10/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "PreviewPastFormView.h"
#import "PreviousFormCell.h"
#import "FormDataModel.h"
#import "PastFormsView.h"
#import "Helper.h"
#import "LoginView.h"
#import "iPadActionSheet.h"
#import "Constants.h"
#import "AppDelegate.h"
//#import "MBProgressHUD.h"
//#import <QuartzCore/QuartzCore.h>
@interface PreviewPastFormView ()<UIPopoverControllerDelegate,sharedDelegate>

@end

@implementation PreviewPastFormView
@synthesize tableView,previousCell;
@synthesize searchBtn;
@synthesize searchrequest;
@synthesize datepickerView,toolbar;
@synthesize sortOptionsArray,sortOrderPickerView;
@synthesize typeArray,typePickerView;
@synthesize mainArray;
@synthesize indicator;
@synthesize mainDict;
@synthesize responseArray;
//@synthesize hud;
@synthesize accessToken;
@synthesize userName;
@synthesize usernameLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    self.searchBtn.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    self.searchBtn.layer.cornerRadius=3.0f;
    
    //token set
    self.accessToken = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"token"];
    //username
    self.userName = [[NSUserDefaults standardUserDefaults]
                     stringForKey:@"loggedInUserName"];
    self.usernameLbl.text=self.userName;
    //creating toolbar
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
    
    
    //creating date picker view
    self.datepickerView=[[UIDatePicker alloc]init];
    self.datepickerView.datePickerMode = UIDatePickerModeDate;
    
    self.fromDatetxtfield.inputView = datepickerView;
    self.toDatetxtfield.inputView = datepickerView;
    
    self.fromDatetxtfield.inputAccessoryView=self.toolbar;
    self.toDatetxtfield.inputAccessoryView=self.toolbar;
    self.keywordTxtfield.inputAccessoryView=self.toolbar;
    self.keywordTxtfield.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.keywordTxtfield.layer.borderWidth= 1.0f;
    
    self.fromDatetxtfield.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.fromDatetxtfield.layer.borderWidth= 1.0f;
    
    self.toDatetxtfield.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.toDatetxtfield.layer.borderWidth= 1.0f;
    
    self.sortOrderTxtfield.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.sortOrderTxtfield.layer.borderWidth= 1.0f;
    
    self.formTypetxtfield.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
    self.formTypetxtfield.layer.borderWidth= 1.0f;
    
    //creating option picker view
    self.sortOptionsArray=[[NSMutableArray alloc]initWithObjects:@"Newest at top",@"Oldest at top",@"Alphabetical by Title" ,nil];
    
    self.typeArray=[[NSMutableArray alloc]initWithObjects:@"Submission Form",nil];
    
    sortOrderPickerView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    typePickerView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    
    sortOrderPickerView.delegate = self;
    typePickerView.delegate=self;
    
    [sortOrderPickerView setShowsSelectionIndicator:YES];
    [typePickerView setShowsSelectionIndicator:YES];
    
    
    self.sortOrderTxtfield.inputView = sortOrderPickerView;
    
    self.sortOrderTxtfield.inputAccessoryView=self.toolbar;
    
    self.formTypetxtfield.inputView =typePickerView;
    
    self.formTypetxtfield.inputAccessoryView=self.toolbar;
    self.mainArray=[[NSMutableArray alloc]init];
    [self.indicator stopAnimating];
    [self.indicator setHidden:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PreviousFormCell";
    [previousCell setSelectionStyle:UITableViewCellSelectionStyleGray]; //for
    previousCell = (PreviousFormCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.previousCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PreviousFormCell" owner:self options:nil];
        self.previousCell = [nib objectAtIndex:0];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 5, 670, 45) cornerRadius:2.0];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.cornerRadius=5.0;
    //shapeLayer.fillColor = [[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f] CGColor];
    
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.previousCell.contentView.layer addSublayer:shapeLayer];
    
    FormDataModel *formdataModel = (FormDataModel*)[self.mainArray objectAtIndex:indexPath.row];
    self.previousCell.dateLbl.text=formdataModel.dateCreated;
    self.previousCell.propLbl.text=formdataModel.propertyAddress;
    return previousCell;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 11;
    return mainArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PastFormsView *pastformVC=[[PastFormsView alloc]initWithNibName:@"PastFormsView" bundle:nil];
    pastformVC.mainDictionary=[responseArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:pastformVC animated:YES];
    
    
    
}
- (IBAction)doSearch:(id)sender {
    [self keyboardhide];
    [self.mainArray removeAllObjects];
    [self.tableView reloadData];
    [self searchRequest];
}

-(void)searchRequest{
    NSString *bearer=@"Bearer ";
    
    NSString *finalString = [bearer stringByAppendingString:accessToken];
    // NSLog(@"finalString:%@",finalString);
    // NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.SmartHub/api/search"];
    
    
    //NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.SmartHub/api/search?page=1&perpage=100&$orderby=CreatedDate"];
    
    //NSString *company=@"Thehub Impact";
    NSString *keyword=self.keywordTxtfield.text;
    //NSString *company=@"Jack";
    NSString *propertyAddress= self.keywordTxtfield.text;
    NSString *prepairedBy=@"me";
    NSString *fromDate=self.fromDatetxtfield.text;
    NSString *toDate=self.toDatetxtfield.text;
    NSString *form=self.formTypetxtfield.text;
    NSString *orderby=@"Title";
    
    // NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.SmartHub/api/search?CompanyName=%@&PropertyAddress=%@PreparedBy=%@FromDate=%@ToDate=%@&page=1&perpage=100&$orderby=CreatedDate&typeName=%@",company,propertyAddress,prepairedBy,fromDate,toDate,form];
    
//    NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.Smarthub/api/search?page=1&perpage=100&orderby=CreatedDate&CompanyName=%@&PropertyAddress=%@&PreparedBy=%@&FromDate=%@&ToDate=%@",company,propertyAddress,prepairedBy,fromDate,toDate];
//
    
    NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/auth.Smarthub/api/search?keyword=%@",keyword];
    
    

    
    
    NSString *fixedURL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSLog(@"logging url string %@ and \n encoded url string %@", URL, fixedURL);
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    
    [request addRequestHeader:@"Authorization" value:finalString];
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    
    
}




-(void)requestStarted:(ASIHTTPRequest *)request{
    //[self showhud];
    self.indicator.hidden=NO;
    [self.indicator startAnimating];
}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    [self.indicator stopAnimating];
    [self.indicator setHidden:YES];
    NSString *response = [request responseString];
    
    
    NSLog(@"*****response::::::::::%@",response);
    
    
    
    if([request.responseString.JSONValue isKindOfClass:[NSMutableArray class]])
    {
        
        responseArray = [request.responseString JSONValue];
        NSLog(@"array:%@",responseArray);
        NSLog(@"array Count:%d",responseArray.count);
        
        if (responseArray == nil || [responseArray count] == 0)
        {
            
            UIAlertView *emptyAlert=[[UIAlertView alloc]initWithTitle:@"Search!" message:@"No results found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [emptyAlert show];
            
        }
        else
        {
            
            
            for (int k = 0; k<[responseArray count]; k++)
            {
                mainDict=[responseArray objectAtIndex:k];
                NSLog(@"dict::%@",mainDict);
                NSString *createdDate=[mainDict valueForKey:@"CreatedDate"];
                NSLog(@"CreatedDate:%@",createdDate);
                
                NSString *title=[mainDict valueForKey:@"Title"];
                if (title == (id)[NSNull null])
                {
                    title = [NSString stringWithFormat:@"Property Address at %@", [mainDict valueForKey:@"PropertyAddress"]];
                }
                NSLog(@"title:%@",title);
                FormDataModel *formdataModel=[[FormDataModel alloc]init];
                formdataModel.dateCreated=createdDate;
                formdataModel.propertyAddress=title;
                [self.mainArray addObject:formdataModel];
                NSLog(@"mainArray::%@",self.mainArray);
            }
            [self.tableView reloadInputViews];
            [self.tableView reloadData];
            [self.indicator stopAnimating];
            [self.indicator setHidden:YES];
            //[self hidehud];
            
        }
        
        
    }
    else
    {
        [self.tableView reloadInputViews];
        [self.tableView reloadData];
        [self.indicator stopAnimating];
        [self.indicator setHidden:YES];
        NSDictionary *responsedict = [request.responseString JSONValue];
        NSLog(@"responsedict:%@",responsedict);
        
        NSString *errormsg=[responsedict valueForKey:@"Message"];
        
        UIAlertView *errorAlert=[[UIAlertView alloc]initWithTitle:errormsg message:[responsedict valueForKey:@"ExceptionMessage"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [errorAlert show];
        
    }
    
    // NSDictionary *responsedict= [request.responseString JSONValue];
    
    // [self notifyErrorMessage:[responsedict valueForKey:@"Message"]];
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [self.indicator stopAnimating];
    [self.indicator setHidden:YES];
    NSError *error = [request error];
    
    NSLog(@"request:*****%@",error.localizedDescription);
    
    // [self hidehud];
    //[self notifyErrorMessage:error.localizedDescription];
    
    
    UIAlertView *failureAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [failureAlert show];
    
    
    
}

#pragma UIDatePicker Delegates

- (void)DatePickerDoneClick:(id)sender{
    
    NSDate *date=[self.datepickerView date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *datestring;
    datestring = [df stringFromDate:date];
    
    if ([self.fromDatetxtfield isFirstResponder]) {
        self.fromDatetxtfield.text=[NSString stringWithFormat:@"%@",datestring];
        
        
    }
    else if ([self.toDatetxtfield isFirstResponder])
    {
        self.toDatetxtfield.text=[NSString stringWithFormat:@"%@",datestring];
        
    }
    [self keyboardhide];
    
    
}
- (void)DatePickerCancelClick:(id)sender{
    
    //if ([self.keywordTxtfield isFirstResponder]) {
    // self.keywordTxtfield.text=@"";
    //}
    [self keyboardhide];
}



#pragma UIPicker Delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView==self.sortOrderPickerView) {
        return [self.sortOptionsArray count];
    }
    else{
        return [self.typeArray count];
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView==self.sortOrderPickerView) {
        return  [self.sortOptionsArray objectAtIndex:row];
    }
    else
    {
        return  [self.typeArray objectAtIndex:row];
        
    }
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==self.sortOrderPickerView) {
        self.sortOrderTxtfield.text = (NSString *)[self.sortOptionsArray objectAtIndex:row];
    }
    else
    {
        self.formTypetxtfield.text = (NSString *)[self.typeArray objectAtIndex:row];
    }
    
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *pickerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    
    pickerlabel.textAlignment=NSTextAlignmentCenter;
    // pickerlabel.font=FONT_ROBOTO(14);
    //if (IS_IPAD) {
    //pickerlabel.font = FONT_ROBOTO(16);
    //}
    if (pickerView==self.sortOrderPickerView) {
        pickerlabel.text = [NSString stringWithFormat:@" %@", [self.sortOptionsArray objectAtIndex:row]];
    }
    else{
        pickerlabel.text = [NSString stringWithFormat:@" %@", [self.typeArray objectAtIndex:row]];
    }
    
    return pickerlabel;
}
-(void)keyboardhide{
    [self.fromDatetxtfield resignFirstResponder];
    [self.toDatetxtfield resignFirstResponder];
    [self.keywordTxtfield resignFirstResponder];
    [self.formTypetxtfield resignFirstResponder];
    [self.sortOrderTxtfield resignFirstResponder];
}
- (IBAction)move:(id)sender {
    PastFormsView *pastformVC=[[PastFormsView alloc]initWithNibName:@"PastFormsView" bundle:nil];
    [self.navigationController pushViewController:pastformVC animated:YES];
    
}
#pragma mark Sharedelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
    [self shareAction:buttonIndex];
}

- (void)promptToShareOfType:(int)tag
{
    NSLog(@"tag::%d",tag);
    [self shareAction:tag];
}

-(void) shareAction:(NSInteger) buttonIndex
{
    
    
    switch (buttonIndex) {
        case 0:
            [self LogOut];
            break;
        case 1:
            [self cancel];
            break;
            
        default:
            break;
    }
}

-(void)LogOut{
    /*
     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loggedInUserName"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     */
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate createLoginView];
    
}

-(void)cancel{
    NSLog(@"cancek tapped");
    
}
- (IBAction)LogOutBtnTapped:(id)sender{
    UIButton *selectedBtn = (UIButton *)sender;
    iPadActionSheet * shareView = [[iPadActionSheet alloc] initWithNibName:@"iPadActionSheet" bundle:nil];
    shareView.delegate = self;
    
    APP_DEL.popUp = [[UIPopoverController alloc] initWithContentViewController:shareView];
    APP_DEL.popUp.delegate = self;
    APP_DEL.popUp.popoverContentSize = CGSizeMake(200, 140);
    CGRect ref = [selectedBtn frame];
    CGRect pointRectRef = [selectedBtn convertRect:[selectedBtn bounds] toView:self.view];
    CGRect pointRect = [selectedBtn convertRect:[selectedBtn bounds] toView:self.view.superview];
    pointRect.origin.x = ref.origin.x;
    //            NSLog(@"show up %d",pointRect.origin.y > (self.navigationController.navigationBar.frame.size.height + 190));
    if (pointRect.origin.y > (self.navigationController.navigationBar.frame.size.height + 240)) {
        [APP_DEL.popUp presentPopoverFromRect:pointRectRef inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
    else{
        [APP_DEL.popUp presentPopoverFromRect:pointRectRef inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
    
}
/*
 #pragma mark hudactions
 
 -(void)showhud{
 self.hud=[Helper getHudforview:self.view];
 [self.view addSubview:self.hud];
 self.hud.labelFont = [UIFont boldSystemFontOfSize:12.0f];
 self.hud.labelText=@"Searching..";
 [self.hud show:YES];
 }
 
 -(void)hidehud{
 [self.hud hide:YES afterDelay:1];
 }
 -(void) notifyErrorMessage:(NSString *) errMsg{
 [self showhud];
 self.hud.labelText = errMsg;
 [self hidehud];
 }
 */
@end
