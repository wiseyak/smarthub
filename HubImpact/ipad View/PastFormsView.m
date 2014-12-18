//
//  PastFormsView.m
//  HubImpact
//
//  Created by Prakash Maharjan on 9/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "PastFormsView.h"
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

#import "SearchDetailModel.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


@interface PastFormsView ()

@property (strong, nonatomic) UIWebView* detailsWebView;

@end

@implementation PastFormsView
@synthesize cleanlinessCell,repairsCell,generalCommentsCell,futureVisitCell,insuranceCell,declarationCell,inspectionCell,commentsCell,noteDamageCell,noteBreakageCell,finalCell,headerCell;
@synthesize titleArray;
@synthesize tempRefCell;
@synthesize rect;
@synthesize propertyAddressTxt,prepairedByTxt;
@synthesize mainDictionary;
@synthesize companyNameLbl;
@synthesize mainArray;
@synthesize Array;

//visual comments radio buttons array
@synthesize gutterRbArray,windowsRbArray,wallsRbArray,roofRbArray,fencingRbArray,gatesRbArray,gardenRbArray,comAreaRbArray,smokeDetectorRbArray;
@synthesize futureVisitRbArray; //future visit array
@synthesize insuranceRbArray; //insurance array
//final words array
@synthesize finalwordsRbArray,finalwordsRbArray2;
@synthesize commentsRadioArray,radioArray;

//cleanliness cell 1
@synthesize cl1floor1RbArray,cl1wall1Rb1Array,cl1windows1Rb1Array,cl1curtains1Rb1Array,cl1furnishing1Rb1Array;



@synthesize detailsWebView = _detailsWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setHidden:YES];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
//      self.titleArray=[[NSMutableArray alloc]initWithObjects:@"External-Basic Visual Comments (as appropriate)",@"Cleanliness",@"Note Any Damage",@"Note Any Breakages",@"Outstanding Repairs",@"General Comments",@"Declaration",@"Future Visits",@"Insurance",@"Inspection Date and Time",@"Final Words",nil];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    
    self.detailsWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0, 10.0, [[UIScreen mainScreen] bounds].size.width -20.0, [[UIScreen mainScreen] bounds].size.height)];
    self.detailsWebView.delegate = self;

    [self.view addSubview:self.detailsWebView];
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.93.95.189/TheHubAuth/search/details1/%@",[self.mainDictionary objectForKey:@"Id"]]];
    
    NSMutableURLRequest* detailViewRequest=[NSMutableURLRequest requestWithURL:url];
    
    
    
    NSString *bearer=@"Bearer ";
    NSString* accessToken = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"token"];
    NSString* bearerString = [bearer stringByAppendingString:accessToken];
    [detailViewRequest setHTTPMethod:@"GET"];
    [detailViewRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [detailViewRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [detailViewRequest addValue:bearerString forHTTPHeaderField:@"Authorization"];
    
    [self.detailsWebView loadRequest:detailViewRequest];
    
//    self.propertyAddressTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
//    self.propertyAddressTxt.layer.borderWidth= 1.0f;
    
//    self.prepairedByTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    
//    self.prepairedByTxt.layer.borderWidth= 1.0f;
//    self.prepairedByTxt.userInteractionEnabled=NO;
//    self.propertyAddressTxt.userInteractionEnabled=NO;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSLog(@"mainDictionary::%@",self.mainDictionary);
    
//    
//    NSString *title=[self.mainDictionary valueForKey:@"Title"];
//   
//    if (title == (id)[NSNull null])
//    {
//        title=@"Not Available";
//    }
//    self.navigationItem.title =title;
//    self.companyNameLbl.text=[self.mainDictionary valueForKey:@"Company"];
//    self.propertyAddressTxt.text=[self.mainDictionary valueForKey:@"PropertyAddress"];
//    self.prepairedByTxt.text=[self.mainDictionary valueForKey:@"PreparedBy"];
//    self.Array=[[NSMutableArray alloc]init];
//    self.mainArray=[self.mainDictionary valueForKey:@"Groups"];
//    
//    
//    NSLog(@"loggin main array %@", self.mainArray);
//   // NSLog(@"mainArray:%@",self.mainArray);
//    for (int i=0; i<self.mainArray.count; i++) {
//   
//       // SearchDetailModel *smodel = [[SearchDetailModel alloc] init];
//        NSDictionary *dict = [self.mainArray objectAtIndex:i];
//        NSLog(@"dict:%@",dict);
//        NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
//        for (int j=0; j<arr.count; j++)
//        {
//            NSDictionary *di = [arr objectAtIndex:j];
//            NSMutableArray *aa=[di valueForKey:@"Fields"];
//            for (int k=0; k<aa.count; k++) {
//                NSMutableDictionary *ddd=[aa objectAtIndex:k];
//                NSLog(@"ddd:%@",ddd);
//                
//            }
//
//        }
//
//        //[self.Array addObject:smodel];
//       
//        ////
//         NSLog(@"Array::%@",self.Array);
//        [self.tableView reloadData];
//        //NSLog(@"val:::%@",smodel.value);
//    }
//
//    self.radioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO", nil];
//    
//    self.commentsRadioArray=[[NSMutableArray alloc]initWithObjects:@"YES",@"NO",@"N/A", nil];
//    
//    //radio button array for visual comments cell
//    self.gutterRbArray = [NSMutableArray new];
//    self.windowsRbArray=[NSMutableArray new];
//    self.wallsRbArray=[NSMutableArray new];
//    self.roofRbArray=[NSMutableArray new];
//    self.fencingRbArray=[NSMutableArray new];
//    self.gatesRbArray=[NSMutableArray new];
//    self.gardenRbArray=[NSMutableArray new];
//    self.comAreaRbArray=[NSMutableArray new];
//    self.smokeDetectorRbArray=[NSMutableArray new];
//    
//    //radio button array for future visit cell
//    self.futureVisitRbArray = [NSMutableArray new];
//    
//    //radio button array for insurance cell
//    self.insuranceRbArray = [NSMutableArray new];
//    
//    //radio button array for final words comments cell
//    self.finalwordsRbArray = [NSMutableArray new];
//    self.finalwordsRbArray2 = [NSMutableArray new];
//    
//    
//    //radio button array for - cleanliness cell 1
//    self.cl1floor1RbArray=[NSMutableArray new];
//    self.cl1wall1Rb1Array=[NSMutableArray new];
//    self.cl1windows1Rb1Array=[NSMutableArray new];
//    self.cl1curtains1Rb1Array=[NSMutableArray new];
//    self.cl1furnishing1Rb1Array=[NSMutableArray new];
//
//    
    
}


- (BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType) navigationType {

    BOOL headerIsPresent = ([[request allHTTPHeaderFields] objectForKey:@"Authorization"]!=nil);
    
    if(headerIsPresent) return YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [request URL];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            
            NSString *bearer=@"Bearer ";
            NSString* accessToken = [[NSUserDefaults standardUserDefaults]
                                     stringForKey:@"token"];
            NSString* bearerString = [bearer stringByAppendingString:accessToken];
            [request setHTTPMethod:@"GET"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

            [request addValue:bearerString forHTTPHeaderField:@"Authorization"];
            // reload the request
            [self.detailsWebView loadRequest:request];
        });
    });
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   // return 1;
    
    //return servicesDataArray.count;
    return 11;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        // return 600; //visual comments
        return 1500;
        
    }
    if (indexPath.section==1){
        return 270; //cleanliness
        
    }
    if (indexPath.section==2){
        return 200; //note damage
    }
    if (indexPath.section==3){
        return 200; //note breakage
        
    }
    if (indexPath.section==4){
        return 200; //outstanding repair
        
        
    }
    if (indexPath.section==5){
        return 200; //general comments
        
    }
    if (indexPath.section==6){
        return 350; //declaration
        
    }
    if (indexPath.section==7){
        return 150; // future visits
        
    }
    if (indexPath.section==8){
        return 200; //insurance
        
    }
    if (indexPath.section==9){
        return 150; //inspection date and time
        
    }
    if (indexPath.section==10){
        return 140; //final words
        
    }
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.section==0)
            
        {
            
            static NSString *commentIdentifier = @"VisualCommentsCell";
            [commentsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            commentsCell = (VisualCommentsCell *)[self.tableView dequeueReusableCellWithIdentifier:commentIdentifier];
            if (self.commentsCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VisualCommentsCell" owner:self options:nil];
                self.commentsCell = [nib objectAtIndex:0];
            }
            
            
            NSLog(@"logging at index 7 %@", self.mainArray);
            NSDictionary *visualcommentDict = [self.mainArray objectAtIndex:7];//;//[self.mainArray objectAtIndex:7];
            
            
            
            NSLog(@"visualcommentDict:%@",visualcommentDict);
            NSMutableArray *arr=[visualcommentDict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:1];
            NSLog(@"ddd:%@",ddd);
            NSString *guttercommentvalue=[ddd valueForKey:@"Value"];
            self.commentsCell.gutterTxt.text=guttercommentvalue;
            ddd=[aa objectAtIndex:3];
            NSString *windowcommentvalue=[ddd valueForKey:@"Value"];
            self.commentsCell.windowTxt.text=windowcommentvalue;
            
//            ddd=[aa objectAtIndex:5];
//            NSString *wallscommentvalue=[ddd valueForKey:@"Value"];
            self.commentsCell.wallTxt.text=@"replace this plz";//wallscommentvalue;
            
//            ddd=[aa objectAtIndex:7];
//            NSString *rooftilecommentvalue=[ddd valueForKey:@"Value"];
            self.commentsCell.roofTileTxt.text=@"replace this plz";//rooftilecommentvalue;
//            
//            ddd=[aa objectAtIndex:9];
//            NSString *fencingcommentvalue=[ddd valueForKey:@"Value"];
//            self.commentsCell.fencingTxt.text=fencingcommentvalue;
//            
//            ddd=[aa objectAtIndex:11];
//            NSString *gatescommentvalue=[ddd valueForKey:@"Value"];
//            self.commentsCell.gatesTxt.text=gatescommentvalue;
//            
//            ddd=[aa objectAtIndex:13];
//            NSString *gardencommentvalue=[ddd valueForKey:@"Value"];
//            self.commentsCell.gardenTxt.text=gardencommentvalue;
//            
//            ddd=[aa objectAtIndex:15];
//            NSString *commAreacommentvalue=[ddd valueForKey:@"Value"];
//            self.commentsCell.commAreaTxt.text=commAreacommentvalue;
//            
//            ddd=[aa objectAtIndex:17];
//            NSString *smokecommentvalue=[ddd valueForKey:@"Value"];
//            self.commentsCell.smokeDetectorTxt.text=smokecommentvalue;
//            
//         ddd=[aa objectAtIndex:0];
//         NSString *gutterRadiovalue=[ddd valueForKey:@"Value"];
//        
//            
//        //Visual comments cell gutter radio button
//            for (int g = 0; g < 3; g++) {
//                
//                UIButton *gutterRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [gutterRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [gutterRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [gutterRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:g]] forState:UIControlStateNormal];
//                [gutterRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                gutterRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//            
//                
//                if (g==0)
//                {
//                    
//                    
//                    [gutterRadioButton setFrame:CGRectMake(VISUAL_X_1, 28, 80, 44)];
//
//                    if ([gutterRadiovalue isEqualToString:@"YES"]) {
//                        [gutterRadioButton setSelected:YES];
//                    }
//                }
//                else if(g==1)
//                {
//                    [gutterRadioButton setFrame:CGRectMake(VISUAL_X_2, 28, 80, 44)];
//                    if ([gutterRadiovalue isEqualToString:@"NO"]) {
//                        [gutterRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [gutterRadioButton setFrame:CGRectMake(VISUAL_X_3, 28, 80, 44)];
//                    if ([gutterRadiovalue isEqualToString:@"N/A"]) {
//                        [gutterRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.gutterRbArray addObject:gutterRadioButton];
//                gutterRadioButton.tag=g;
//            }
//            
//            
//            ddd=[aa objectAtIndex:2];
//            NSString *windowRadiovalue=[ddd valueForKey:@"Value"];
//
//            //Visual comments cell windows radio button
//            for (int w = 0; w < 3; w ++) {
//                
//                UIButton *windowRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [windowRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [windowRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [windowRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:w]] forState:UIControlStateNormal];
//                [windowRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                windowRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (w==0)
//                {
//                    
//                    [windowRadioButton setFrame:CGRectMake(VISUAL_X_1, 175, 80, 44)];
//                    if ([windowRadiovalue isEqualToString:@"YES"]) {
//                        [windowRadioButton setSelected:YES];
//                    }
//                    
//                    
//                }
//                else if(w==1){
//                    [windowRadioButton setFrame:CGRectMake(VISUAL_X_2, 175, 80, 44)];
//                    if ([windowRadiovalue isEqualToString:@"NO"]) {
//                        [windowRadioButton setSelected:YES];
//                    }
//
//                }
//                else{
//                    [windowRadioButton setFrame:CGRectMake(VISUAL_X_3, 175, 80, 44)];
//                    if ([windowRadiovalue isEqualToString:@"N/A"]) {
//                        [windowRadioButton setSelected:YES];
//                    }
//
//                    
//                }
//                
//                [self.windowsRbArray addObject:windowRadioButton];
//                windowRadioButton.tag=w;
//            }
//            
//            ddd=[aa objectAtIndex:4];
//            NSString *wallsRadiovalue=[ddd valueForKey:@"Value"];
//
//            //Visual comments cell walls radio button
//            for (int wa = 0; wa < 3; wa ++) {
//                
//                UIButton *wallsRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [wallsRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [wallsRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [wallsRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:wa]] forState:UIControlStateNormal];
//                [wallsRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                wallsRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (wa==0)
//                {
//                    
//                    [wallsRadioButton setFrame:CGRectMake(VISUAL_X_1, 335, 80, 44)];
//                    if ([wallsRadiovalue isEqualToString:@"YES"]) {
//                        [wallsRadioButton setSelected:YES];
//                    }
//
//                    
//                    
//                }
//                else if(wa==1){
//                    [wallsRadioButton setFrame:CGRectMake(VISUAL_X_2, 335, 80, 44)];
//                    if ([wallsRadiovalue isEqualToString:@"NO"]) {
//                        [wallsRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [wallsRadioButton setFrame:CGRectMake(VISUAL_X_3, 335, 80, 44)];
//                    if ([wallsRadiovalue isEqualToString:@"N/A"]) {
//                        [wallsRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.wallsRbArray addObject:wallsRadioButton];
//                wallsRadioButton.tag=wa;
//            }
//            
//            
//            ddd=[aa objectAtIndex:6];
//            NSString *rooftileRadiovalue=[ddd valueForKey:@"Value"];
//            //Visual comments cell roof/tiles radio button
//            for (int r = 0; r < 3; r ++) {
//                
//                UIButton *roofRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [roofRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [roofRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [roofRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:r]] forState:UIControlStateNormal];
//                [roofRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                roofRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (r==0)
//                {
//                    
//                    [roofRadioButton setFrame:CGRectMake(VISUAL_X_1, 500, 80, 44)];
//                    
//                    if ([rooftileRadiovalue isEqualToString:@"YES"]) {
//                        [roofRadioButton setSelected:YES];
//                    }
//                    
//                    
//                }else if(r==1){
//                    [roofRadioButton setFrame:CGRectMake(VISUAL_X_2, 500, 80, 44)];
//                    if ([rooftileRadiovalue isEqualToString:@"NO"]) {
//                        [roofRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [roofRadioButton setFrame:CGRectMake(VISUAL_X_3, 500, 80, 44)];
//                    if ([rooftileRadiovalue isEqualToString:@"N/A"]) {
//                        [roofRadioButton setSelected:YES];
//                    }
//                    
//                }
//                [self.roofRbArray addObject:roofRadioButton];
//                roofRadioButton.tag=r;
//            }
//            
//            
//            ddd=[aa objectAtIndex:8];
//            NSString *fencingRadiovalue=[ddd valueForKey:@"Value"];
//
//            //Visual comments cell fencing radio button
//            for (int f = 0; f < 3; f ++) {
//                
//                UIButton *fencingRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [fencingRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [fencingRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [fencingRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:f]] forState:UIControlStateNormal];
//                [fencingRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                fencingRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (f==0)
//                {
//                    
//                    [fencingRadioButton setFrame:CGRectMake(VISUAL_X_1, 660, 80, 44)];
//                    if ([fencingRadiovalue isEqualToString:@"YES"]) {
//                        [fencingRadioButton setSelected:YES];
//                    }
//
//                }
//                else if (f==1){
//                    [fencingRadioButton setFrame:CGRectMake(VISUAL_X_2, 660, 80, 44)];
//                    if ([fencingRadiovalue isEqualToString:@"NO"]) {
//                        [fencingRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [fencingRadioButton setFrame:CGRectMake(VISUAL_X_3, 660, 80, 44)];
//                    if ([fencingRadiovalue isEqualToString:@"N/A"]) {
//                        [fencingRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.fencingRbArray addObject:fencingRadioButton];
//                fencingRadioButton.tag=f;
//            }
//            
//            
//            ddd=[aa objectAtIndex:10];
//            NSString *gateRadiovalue=[ddd valueForKey:@"Value"];
//
//            //Visual comments cell gates radio button
//            for (int gt = 0; gt < 3; gt ++) {
//                
//                UIButton *gateRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [gateRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [gateRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [gateRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:gt]] forState:UIControlStateNormal];
//                [gateRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                gateRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (gt==0)
//                {
//                    
//                    [gateRadioButton setFrame:CGRectMake(VISUAL_X_1, 817, 80, 44)];
//                    if ([gateRadiovalue isEqualToString:@"YES"]) {
//                        [gateRadioButton setSelected:YES];
//                    }
//             
//                }
//                else if (gt==1) {
//                    [gateRadioButton setFrame:CGRectMake(VISUAL_X_2, 817, 80, 44)];
//                    if ([gateRadiovalue isEqualToString:@"NO"]) {
//                        [gateRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [gateRadioButton setFrame:CGRectMake(VISUAL_X_3, 817, 80, 44)];
//                    if ([gateRadiovalue isEqualToString:@"N/A"]) {
//                        [gateRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.gatesRbArray addObject:gateRadioButton];
//                gateRadioButton.tag=gt;
//            }
//            
//            ddd=[aa objectAtIndex:12];
//            NSString *gardenRadiovalue=[ddd valueForKey:@"Value"];
//            //Visual comments cell garden radio button
//            for (int gr = 0; gr < 3; gr ++) {
//                
//                UIButton *gardenRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [gardenRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [gardenRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [gardenRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:gr]] forState:UIControlStateNormal];
//                [gardenRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                gardenRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (gr==0)
//                {
//                    
//                    [gardenRadioButton setFrame:CGRectMake(VISUAL_X_1, 990, 80, 44)];
//                   
//                    if ([gardenRadiovalue isEqualToString:@"YES"]) {
//                        [gardenRadioButton setSelected:YES];
//                    }
//                    
//                    
//                }
//                else if (gr==1){
//                    [gardenRadioButton setFrame:CGRectMake(VISUAL_X_2, 990, 80, 44)];
//                    if ([gardenRadiovalue isEqualToString:@"NO"]) {
//                        [gardenRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [gardenRadioButton setFrame:CGRectMake(VISUAL_X_3, 990, 80, 44)];
//                    if ([gardenRadiovalue isEqualToString:@"N/A"]) {
//                        [gardenRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.gardenRbArray addObject:gardenRadioButton];
//                gardenRadioButton.tag=gr;
//            }
//            
//            
//            ddd=[aa objectAtIndex:14];
//            NSString *commAreaRadiovalue=[ddd valueForKey:@"Value"];
//            //Visual comments cell comm. Area radio button
//            for (int ca = 0; ca < 3; ca ++) {
//                
//                UIButton *comaAreaRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [comaAreaRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [comaAreaRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [comaAreaRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:ca]] forState:UIControlStateNormal];
//                [comaAreaRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                comaAreaRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (ca==0)
//                {
//                    
//                    [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_1, 1150, 80, 44)];
//                    if ([commAreaRadiovalue isEqualToString:@"YES"]) {
//                       [comaAreaRadioButton setSelected:YES];
//                    }
//           
//                }else if (ca==1){
//                    [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_2, 1150, 80, 44)];
//                    if ([commAreaRadiovalue isEqualToString:@"NO"]) {
//                        [comaAreaRadioButton setSelected:YES];
//                    }
//                }
//                else{
//                    [comaAreaRadioButton setFrame:CGRectMake(VISUAL_X_3, 1150, 80, 44)];
//                    if ([commAreaRadiovalue isEqualToString:@"N/A"]) {
//                        [comaAreaRadioButton setSelected:YES];
//                    }
//                    
//                }
//                
//                [self.comAreaRbArray addObject:comaAreaRadioButton];
//                comaAreaRadioButton.tag=ca;
//            }
//            
//            ddd=[aa objectAtIndex:16];
//            NSString *smokeRadiovalue=[ddd valueForKey:@"Value"];
//            
//            //Visual comments smoke detectors radio button
//            
//            for (int sd = 0; sd < 3; sd ++) {
//                
//                UIButton *smokeDetectorsRadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [smokeDetectorsRadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//                [smokeDetectorsRadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
//                [smokeDetectorsRadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:sd]] forState:UIControlStateNormal];
//                [smokeDetectorsRadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//                smokeDetectorsRadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
//                
//                if (sd==0)
//                {
//                    
//                    
//                    [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_1, 1318, 80, 44)];
//                    if ([smokeRadiovalue isEqualToString:@"YES"]) {
//                        [smokeDetectorsRadioButton setSelected:YES];
//                    }
//
//                }
//                else if(sd==1)
//                {
//                    [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_2, 1318, 80, 44)];
//                    if ([smokeRadiovalue isEqualToString:@"NO"]) {
//                        [smokeDetectorsRadioButton setSelected:YES];
//                    }
//                    
//                    
//                }
//                else{
//                    [smokeDetectorsRadioButton setFrame:CGRectMake(VISUAL_X_3, 1318, 80, 44)];
//                    if ([smokeRadiovalue isEqualToString:@"N/A"]) {
//                        [smokeDetectorsRadioButton setSelected:YES];
//                    }
//                    
//                    
//                }
//                
//                [self.smokeDetectorRbArray addObject:smokeDetectorsRadioButton];
//                smokeDetectorsRadioButton.tag=sd;
//            }
//            
//
            
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
            
//            [self.commentsCell addSubview:[gutterRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[gutterRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[gutterRbArray objectAtIndex:2]];
//            
//            
//            [self.commentsCell addSubview:[windowsRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[windowsRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[windowsRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[wallsRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[wallsRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[wallsRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[roofRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[roofRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[roofRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[fencingRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[fencingRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[fencingRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[gatesRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[gatesRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[gatesRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[gardenRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[gardenRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[gardenRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[comAreaRbArray objectAtIndex:2]];
//            
//            [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:0]];
//            [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:1]];
//            [self.commentsCell addSubview:[smokeDetectorRbArray objectAtIndex:2]];
//            
//            self.commentsCell.gutterImgView.tag=100;
//            self.commentsCell.windowImgView.tag=101;
//            self.commentsCell.wallsImgView.tag=102;
//            self.commentsCell.roofTileimgView.tag=103;
//            self.commentsCell.fencingImgView.tag=104;
//            self.commentsCell.gatesImgView.tag=105;
//            self.commentsCell.gardenImgView.tag=106;
//            self.commentsCell.commAreaImgView.tag=107;
//            self.commentsCell.smokeDetectorImgView.tag=108;
//            
//            
//            self.commentsCell.gutterTxt.editable=NO;
//            self.commentsCell.windowTxt.editable=NO;
//            self.commentsCell.wallTxt.editable=NO;
//            self.commentsCell.roofTileTxt.editable=NO;
//            self.commentsCell.fencingTxt.editable=NO;
//            self.commentsCell.gatesTxt.editable=NO;
//            self.commentsCell.gardenTxt.editable=NO;
//            self.commentsCell.commAreaTxt.editable=NO;
//            self.commentsCell.smokeDetectorTxt.editable=NO;
//            
//            self.commentsCell.gutterPlaceHolderLbl.hidden=YES;
//            self.commentsCell.windowsPlaceHolderLbl.hidden=YES;
//            self.commentsCell.wallsPlaceHolderLbl.hidden=YES;
//            self.commentsCell.rooftilesPlaceHolderLbl.hidden=YES;
//            self.commentsCell.fencingPlaceHolderLbl.hidden=YES;
//            self.commentsCell.gatesPlaceHolderLbl.hidden=YES;
//            self.commentsCell.gardenPlaceHolderLbl.hidden=YES;
//            self.commentsCell.commAreaPlaceHolderLbl.hidden=YES;
//            self.commentsCell.smokeDetectorPlaceHolderLbl.hidden=YES;
            
            return commentsCell;
            
            
        }
        
        if (indexPath.section==1)
            
        {
            
            static NSString *cleanlinessIdentifier = @"CleanlinessCell";
            [cleanlinessCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            cleanlinessCell = (CleanlinessCell *)[self.tableView dequeueReusableCellWithIdentifier:cleanlinessIdentifier];
            if (self.cleanlinessCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CleanlinessCell" owner:self options:nil];
                self.cleanlinessCell = [nib objectAtIndex:0];
            }
            
            
            NSDictionary *cleanlinessDict = [self.mainArray objectAtIndex:0];
            NSLog(@"cleanlinessDict:%@",cleanlinessDict);
            NSMutableArray *arr=[cleanlinessDict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:5];
            NSLog(@"ddd:%@",ddd);
            NSString *imageValue=[ddd valueForKey:@"Value"];
            NSLog(@"imageValue:%@",imageValue);

            self.cleanlinessCell.scrollView.delegate=self;
            // [self.cleanlinessCell.contentView addSubview:self.cleanlinessCell.scrollView];
            self.cleanlinessCell.scrollView.contentSize=CGSizeMake(15370, 270);

           [self.cleanlinessCell.Reception1Img1 sd_setImageWithURL:[NSURL URLWithString:imageValue] forState:UIControlStateNormal];
            
            /*
             [self.cleanlinessCell.Reception1Img1 setImage:self.r1img1 forState:UIControlStateNormal];
            [self.cleanlinessCell.Reception1Img2 setImage:self.r1img2 forState:UIControlStateNormal];
            [self.cleanlinessCell.Reception1Img3 setImage:self.r1img3 forState:UIControlStateNormal];
                        */
            self.cleanlinessCell.Reception1Img1.imageView.clipsToBounds = YES;
            self.cleanlinessCell.Reception1Img2.imageView.clipsToBounds = YES;
            self.cleanlinessCell.Reception1Img3.imageView.clipsToBounds = YES;
            self.cleanlinessCell.Reception1Img1.tag=0;
            self.cleanlinessCell.Reception1Img2.tag=1;
            self.cleanlinessCell.Reception1Img3.tag=2;
            
            ddd=[aa objectAtIndex:0];
            NSString *floor1RadioValue=[ddd valueForKey:@"Value"];

            //Cleanliness1 floor1 radio button
            
            for (int fl1 = 0; fl1 < 3; fl1 ++) {
                
                UIButton *fl1RadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [fl1RadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [fl1RadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [fl1RadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:fl1]] forState:UIControlStateNormal];
                [fl1RadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                fl1RadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (fl1==0)
                {
                    
                    [fl1RadioButton setFrame:CGRectMake(X_POINT_1, FLOOR_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([floor1RadioValue isEqualToString:@"YES"]) {
                        [fl1RadioButton setSelected:YES];
                    }
                    
                    
                    
                }
                else if(fl1==1)
                {
                    [fl1RadioButton setFrame:CGRectMake(X_POINT_2,FLOOR_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([floor1RadioValue isEqualToString:@"NO"]) {
                        [fl1RadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [fl1RadioButton setFrame:CGRectMake(X_POINT_3, FLOOR_Y_POINT, RADIO_BUTTON_WIDTH,RADIO_BUTTON_HEIGHT)];
                    if ([floor1RadioValue isEqualToString:@"N/A"]) {
                        [fl1RadioButton setSelected:YES];
                    }
                    
                }
                [self.cl1floor1RbArray addObject:fl1RadioButton];
                fl1RadioButton.tag=fl1;
                
            }
            
            
            ddd=[aa objectAtIndex:1];
            NSString *wall1RadioValue=[ddd valueForKey:@"Value"];
            
            
            //Cleanliness1 Walls1 radio button
            
            for (int wa1 = 0; wa1 < 3; wa1 ++) {
                
                UIButton *wa1RadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [wa1RadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [wa1RadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [wa1RadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:wa1]] forState:UIControlStateNormal];
                [wa1RadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                wa1RadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (wa1==0)
                {
                    
                    [wa1RadioButton setFrame:CGRectMake(X_POINT_1, WALLS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([wall1RadioValue isEqualToString:@"YES"]) {
                        [wa1RadioButton setSelected:YES];
                    }

                }
                else if(wa1==1)
                {
                    [wa1RadioButton setFrame:CGRectMake(X_POINT_2,WALLS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([wall1RadioValue isEqualToString:@"NO"]) {
                        [wa1RadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [wa1RadioButton setFrame:CGRectMake(X_POINT_3, WALLS_Y_POINT, RADIO_BUTTON_WIDTH,RADIO_BUTTON_HEIGHT)];
                    if ([wall1RadioValue isEqualToString:@"N/A"]) {
                        [wa1RadioButton setSelected:YES];
                    }
                    
                }
            
                [self.cl1wall1Rb1Array addObject:wa1RadioButton];
                wa1RadioButton.tag=wa1;
            }
            
            ddd=[aa objectAtIndex:2];
            NSString *window1RadioValue=[ddd valueForKey:@"Value"];
            //Cleanliness1 Windows1 radio button
            
            for (int wi1 = 0; wi1 < 3; wi1 ++) {
                
                UIButton *wi1RadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [wi1RadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [wi1RadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [wi1RadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:wi1]] forState:UIControlStateNormal];
                [wi1RadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                wi1RadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (wi1==0)
                {
                    
                    [wi1RadioButton setFrame:CGRectMake(X_POINT_1, WINDOWS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([window1RadioValue isEqualToString:@"YES"]) {
                         [wi1RadioButton setSelected:YES];
                    }
                   
                    
                    
                }
                else if(wi1==1)
                {
                    [wi1RadioButton setFrame:CGRectMake(X_POINT_2,WINDOWS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([window1RadioValue isEqualToString:@"NO"]) {
                        [wi1RadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [wi1RadioButton setFrame:CGRectMake(X_POINT_3, WINDOWS_Y_POINT, RADIO_BUTTON_WIDTH,RADIO_BUTTON_HEIGHT)];
                    if ([window1RadioValue isEqualToString:@"N/A"]) {
                        [wi1RadioButton setSelected:YES];
                    }
                    
                }
             
                [self.cl1windows1Rb1Array addObject:wi1RadioButton];
                wi1RadioButton.tag=wi1;
            }
            
            
            ddd=[aa objectAtIndex:3];
            NSString *curtain1RadioValue=[ddd valueForKey:@"Value"];
            //Cleanliness1 Curtains1 radio button
            
            for (int cu1 = 0; cu1 < 3; cu1 ++) {
                
                UIButton *cu1RadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [cu1RadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [cu1RadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [cu1RadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:cu1]] forState:UIControlStateNormal];
                [cu1RadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                cu1RadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (cu1==0)
                {
                    
                    [cu1RadioButton setFrame:CGRectMake(X_POINT_1, CURTAINS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([curtain1RadioValue isEqualToString:@"YES"]) {
                        [cu1RadioButton setSelected:YES];
                    }
 
                }
                else if(cu1==1)
                {
                    [cu1RadioButton setFrame:CGRectMake(X_POINT_2,CURTAINS_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([curtain1RadioValue isEqualToString:@"NO"]) {
                        [cu1RadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [cu1RadioButton setFrame:CGRectMake(X_POINT_3, CURTAINS_Y_POINT, RADIO_BUTTON_WIDTH,RADIO_BUTTON_HEIGHT)];
                    if ([curtain1RadioValue isEqualToString:@"N/A"]) {
                        [cu1RadioButton setSelected:YES];
                    }
                    
                }
       
                [self.cl1curtains1Rb1Array addObject:cu1RadioButton];
                cu1RadioButton.tag=cu1;
            }
            
            
            ddd=[aa objectAtIndex:4];
            NSString *furnishing1RadioValue=[ddd valueForKey:@"Value"];
            //Cleanliness1 Furnishing1 radio button
            
            for (int fur1 = 0; fur1 < 3; fur1 ++) {
                
                UIButton *fur1RadioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [fur1RadioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [fur1RadioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [fur1RadioButton setTitle:[NSString stringWithFormat:@"%@",[commentsRadioArray objectAtIndex:fur1]] forState:UIControlStateNormal];
                [fur1RadioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                fur1RadioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (fur1==0)
                {
                    
                    [fur1RadioButton setFrame:CGRectMake(X_POINT_1, FURNISHING_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([furnishing1RadioValue isEqualToString:@"YES"]) {
                        [fur1RadioButton setSelected:YES];
                    }
                    
                    
                    
                }
                else if(fur1==1)
                {
                    [fur1RadioButton setFrame:CGRectMake(X_POINT_2,FURNISHING_Y_POINT, RADIO_BUTTON_WIDTH, RADIO_BUTTON_HEIGHT)];
                    if ([furnishing1RadioValue isEqualToString:@"NO"]) {
                        [fur1RadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [fur1RadioButton setFrame:CGRectMake(X_POINT_3, FURNISHING_Y_POINT, RADIO_BUTTON_WIDTH,RADIO_BUTTON_HEIGHT)];
                    if ([furnishing1RadioValue isEqualToString:@"N/A"]) {
                        [fur1RadioButton setSelected:YES];
                    }
                    
                }
      
                [self.cl1furnishing1Rb1Array addObject:fur1RadioButton];
                fur1RadioButton.tag=fur1;
            }

            
            
            //cleanliness cell 1
            [self.cleanlinessCell.view1 addSubview:[cl1floor1RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view1 addSubview:[cl1floor1RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view1 addSubview:[cl1floor1RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view1 addSubview:[cl1wall1Rb1Array objectAtIndex:0]];
            [self.cleanlinessCell.view1 addSubview:[cl1wall1Rb1Array objectAtIndex:1]];
            [self.cleanlinessCell.view1 addSubview:[cl1wall1Rb1Array objectAtIndex:2]];
            
            [self.cleanlinessCell.view1 addSubview:[cl1windows1Rb1Array objectAtIndex:0]];
            [self.cleanlinessCell.view1 addSubview:[cl1windows1Rb1Array objectAtIndex:1]];
            [self.cleanlinessCell.view1 addSubview:[cl1windows1Rb1Array objectAtIndex:2]];
            
            [self.cleanlinessCell.view1 addSubview:[cl1curtains1Rb1Array objectAtIndex:0]];
            [self.cleanlinessCell.view1 addSubview:[cl1curtains1Rb1Array objectAtIndex:1]];
            [self.cleanlinessCell.view1 addSubview:[cl1curtains1Rb1Array objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view1 addSubview:[cl1furnishing1Rb1Array objectAtIndex:0]];
            [self.cleanlinessCell.view1 addSubview:[cl1furnishing1Rb1Array objectAtIndex:1]];
            [self.cleanlinessCell.view1 addSubview:[cl1furnishing1Rb1Array objectAtIndex:2]];
            
            /*
            
            //cleanliness cell 2
            [self.cleanlinessCell.view2 addSubview:[cl2floor2RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view2 addSubview:[cl2floor2RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view2 addSubview:[cl2floor2RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view2 addSubview:[cl2wall2RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view2 addSubview:[cl2wall2RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view2 addSubview:[cl2wall2RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view2 addSubview:[cl2windows2RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view2 addSubview:[cl2windows2RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view2 addSubview:[cl2windows2RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view2 addSubview:[cl2curtains2RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view2 addSubview:[cl2curtains2RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view2 addSubview:[cl2curtains2RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view2 addSubview:[cl2furnishing2RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view2 addSubview:[cl2furnishing2RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view2 addSubview:[cl2furnishing2RbArray objectAtIndex:2]];
            
            
            
            
            
            //cleanliness cell 3
            [self.cleanlinessCell.view3 addSubview:[cl3floor3RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view3 addSubview:[cl3floor3RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view3 addSubview:[cl3floor3RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view3 addSubview:[cl3wall3RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view3 addSubview:[cl3wall3RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view3 addSubview:[cl3wall3RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view3 addSubview:[cl3windows3RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view3 addSubview:[cl3windows3RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view3 addSubview:[cl3windows3RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view3 addSubview:[cl3curtains3RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view3 addSubview:[cl3curtains3RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view3 addSubview:[cl3curtains3RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view3 addSubview:[cl3furnishing3RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view3 addSubview:[cl3furnishing3RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view3 addSubview:[cl3furnishing3RbArray objectAtIndex:2]];
            
            
            
            //cleanliness cell 4
            [self.cleanlinessCell.view4 addSubview:[cl4floor4RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view4 addSubview:[cl4floor4RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view4 addSubview:[cl4floor4RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view4 addSubview:[cl4wall4RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view4 addSubview:[cl4wall4RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view4 addSubview:[cl4wall4RbArray objectAtIndex:2]];

            [self.cleanlinessCell.view4 addSubview:[cl4curtains4RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view4 addSubview:[cl4curtains4RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view4 addSubview:[cl4curtains4RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view4 addSubview:[cl4furnishing4RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view4 addSubview:[cl4furnishing4RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view4 addSubview:[cl4furnishing4RbArray objectAtIndex:2]];
            
            
            
            
            //cleanliness cell 5
            [self.cleanlinessCell.view5 addSubview:[cl5floor5RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view5 addSubview:[cl5floor5RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view5 addSubview:[cl5floor5RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view5 addSubview:[cl5wall5RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view5 addSubview:[cl5wall5RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view5 addSubview:[cl5wall5RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view5 addSubview:[cl5windows5RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view5 addSubview:[cl5windows5RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view5 addSubview:[cl5windows5RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view5 addSubview:[cl5curtains5RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view5 addSubview:[cl5curtains5RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view5 addSubview:[cl5curtains5RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view5 addSubview:[cl5furnishing5RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view5 addSubview:[cl5furnishing5RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view5 addSubview:[cl5furnishing5RbArray objectAtIndex:2]];
            
            
            
            
            //cleanliness cell 6
            [self.cleanlinessCell.view6 addSubview:[cl6floor6RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view6 addSubview:[cl6floor6RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view6 addSubview:[cl6floor6RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view6 addSubview:[cl6wall6RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view6 addSubview:[cl6wall6RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view6 addSubview:[cl6wall6RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view6 addSubview:[cl6windows6RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view6 addSubview:[cl6windows6RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view6 addSubview:[cl6windows6RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view6 addSubview:[cl6curtains6RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view6 addSubview:[cl6curtains6RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view6 addSubview:[cl6curtains6RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view6 addSubview:[cl6furnishing6RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view6 addSubview:[cl6furnishing6RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view6 addSubview:[cl6furnishing6RbArray objectAtIndex:2]];
            
            
            
            
            //cleanliness cell 7
            [self.cleanlinessCell.view7 addSubview:[cl7floor7RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view7 addSubview:[cl7floor7RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view7 addSubview:[cl7floor7RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view7 addSubview:[cl7wall7RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view7 addSubview:[cl7wall7RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view7 addSubview:[cl7wall7RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view7 addSubview:[cl7windows7RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view7 addSubview:[cl7windows7RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view7 addSubview:[cl7windows7RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view7 addSubview:[cl7curtains7RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view7 addSubview:[cl7curtains7RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view7 addSubview:[cl7curtains7RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view7 addSubview:[cl7furnishing7RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view7 addSubview:[cl7furnishing7RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view7 addSubview:[cl7furnishing7RbArray objectAtIndex:2]];
            
            
            
            
            //cleanliness cell 8
            [self.cleanlinessCell.view8 addSubview:[cl8floor8RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view8 addSubview:[cl8floor8RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view8 addSubview:[cl8floor8RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view8 addSubview:[cl8wall8RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view8 addSubview:[cl8wall8RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view8 addSubview:[cl8wall8RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view8 addSubview:[cl8windows8RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view8 addSubview:[cl8windows8RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view8 addSubview:[cl8windows8RbArray objectAtIndex:2]];
            
            [self.cleanlinessCell.view8 addSubview:[cl8curtains8RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view8 addSubview:[cl8curtains8RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view8 addSubview:[cl8curtains8RbArray objectAtIndex:2]];
            
            
            [self.cleanlinessCell.view8 addSubview:[cl8furnishing8RbArray objectAtIndex:0]];
            [self.cleanlinessCell.view8 addSubview:[cl8furnishing8RbArray objectAtIndex:1]];
            [self.cleanlinessCell.view8 addSubview:[cl8furnishing8RbArray objectAtIndex:2]];
            
            */self.cleanlinessCell.reception1txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception1txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception2txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception2txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception3txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception3txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception4txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception4txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception5txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception5txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception6txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception6txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception7txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception7txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception8txtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.cleanlinessCell.reception8txtField.layer.borderWidth= 1.0f;
            
            self.cleanlinessCell.reception1txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception2txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception3txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception4txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception5txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception6txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception7txtField.userInteractionEnabled=NO;
            self.cleanlinessCell.reception8txtField.userInteractionEnabled=NO;
           
            return cleanlinessCell;
            
        }
        
        if (indexPath.section==2)
            
        {
            
            static NSString *damageIdentifier = @"NoteDamageCell";
            [noteDamageCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            noteDamageCell = (NoteDamageCell *)[self.tableView dequeueReusableCellWithIdentifier:damageIdentifier];
            if (self.noteDamageCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteDamageCell" owner:self options:nil];
                self.noteDamageCell = [nib objectAtIndex:0];
            }
            
            self.noteDamageCell.noteDamageTxt.layer.borderWidth = 1.0f;
            self.noteDamageCell.noteDamageTxt.layer.cornerRadius=8.0f;
            self.noteDamageCell.noteDamageTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            self.noteDamageCell.noteDamageTxt.editable=NO;
            self.noteDamageCell.damagePlaceholder.hidden=YES;
            NSLog(@"mainArray::%@",self.mainArray);
            
            NSDictionary *dict = [self.mainArray objectAtIndex:8];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
        
                NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
                NSMutableArray *aa=[di valueForKey:@"Fields"];
             NSLog(@"aa:%@",aa);
                    NSMutableDictionary *ddd=[aa objectAtIndex:0];
                    NSLog(@"ddd:%@",ddd);
            NSString *value=[ddd valueForKey:@"Value"];
            NSLog(@"value:::%@", value);
                    

            self.noteDamageCell.noteDamageTxt.text=value;
            
            return noteDamageCell;
            
        }
        
        
        if (indexPath.section==3)
            
        {
            
            static NSString *breakageIdentifier = @"NoteBreakageCell";
            [noteBreakageCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            noteBreakageCell = (NoteBreakageCell *)[self.tableView dequeueReusableCellWithIdentifier:breakageIdentifier];
            if (self.noteBreakageCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteBreakageCell" owner:self options:nil];
                self.noteBreakageCell = [nib objectAtIndex:0];
            }
            
            self.noteBreakageCell.breakageTxt.layer.borderWidth = 1.0f;
            self.noteBreakageCell.breakageTxt.layer.cornerRadius=8.0f;
            self.noteBreakageCell.breakageTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            self.noteBreakageCell.breakageTxt.editable=NO;
            
            NSDictionary *dict = [self.mainArray objectAtIndex:9];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *value=[ddd valueForKey:@"Value"];
            self.noteBreakageCell.breakageTxt.text=value;
            self.noteBreakageCell.breakagePlaceholder.hidden=YES;

           
            return noteBreakageCell;
            
        }
        
        
        if (indexPath.section==4)
            
        {
            
            
            static NSString *repairIdentifier = @"RepairsCell";
            [repairsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            repairsCell = (RepairsCell *)[self.tableView dequeueReusableCellWithIdentifier:repairIdentifier];
            if (self.repairsCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RepairsCell" owner:self options:nil];
                self.repairsCell = [nib objectAtIndex:0];
            }
           // normalkeyboardtoolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
            //self.outstandingRepairTxt=self.repairsCell.repairTxt.text;
            self.repairsCell.repairTxt.layer.borderWidth = 1.0f;
            self.repairsCell.repairTxt.layer.cornerRadius=8.0f;
            self.repairsCell.repairTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            self.repairsCell.repairTxt.editable=NO;
            NSDictionary *dict = [self.mainArray objectAtIndex:1];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *value=[ddd valueForKey:@"Value"];
            self.repairsCell.repairTxt.text=value;
            self.repairsCell.repairPlaceholder.hidden=YES;
            return repairsCell;
            
        }
        
        
        if (indexPath.section==5)
            
        {
            
            
            static NSString *generalIdentifier = @"GeneralCommentsCell";
            [generalCommentsCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            generalCommentsCell = (GeneralCommentsCell *)[self.tableView dequeueReusableCellWithIdentifier:generalIdentifier];
            if (self.generalCommentsCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GeneralCommentsCell" owner:self options:nil];
                self.generalCommentsCell = [nib objectAtIndex:0];
            }
            
            self.generalCommentsCell.generalCommentsTxt.layer.borderWidth = 1.0f;
            self.generalCommentsCell.generalCommentsTxt.layer.cornerRadius=8.0f;
            self.generalCommentsCell.generalCommentsTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
           // [self createToolBar];
            self.generalCommentsCell.generalCommentsTxt.editable=NO;
            
            NSDictionary *dict = [self.mainArray objectAtIndex:2];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *value=[ddd valueForKey:@"Value"];
            self.generalCommentsCell.generalCommentsTxt.text=value;
            self.generalCommentsCell.generalCommmentsPlaceholder.hidden=YES;
            return generalCommentsCell;
            
        }
        
        if (indexPath.section==6)
            
        {
            static NSString *declareIdentifier = @"DeclarationCell";
            [declarationCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            declarationCell = (DeclarationCell *)[self.tableView dequeueReusableCellWithIdentifier:declareIdentifier];
            if (self.declarationCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeclarationCell" owner:self options:nil];
                self.declarationCell = [nib objectAtIndex:0];
            }
            self.declarationCell.declarationDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.declarationCell.declarationDateTxt.layer.borderWidth= 1.0f;
            
            
            self.declarationCell.teenantSignatureTxt.layer.borderWidth = 1.0f;
            self.declarationCell.teenantSignatureTxt.layer.borderColor = [    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            
            
            self.declarationCell.behalfTxt.layer.borderWidth = 1.0f;
            self.declarationCell.behalfTxt.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            self.declarationCell.behalfTxt.editable=NO;
            self.declarationCell.teenantSignatureTxt.editable=NO;
            self.declarationCell.declarationDateTxt.userInteractionEnabled=NO;

            
            rect=  CGRectMake(30, 25, 705, 300);
            
            tempRefCell=self.declarationCell;
            [self createBorder];
            
            
            NSDictionary *dict = [self.mainArray objectAtIndex:5];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *sign=[aa objectAtIndex:0];
            NSLog(@"sign:%@",sign);
            NSString *signvalue=[sign valueForKey:@"Value"];
            NSMutableDictionary *behalf=[aa objectAtIndex:1];
            NSMutableDictionary *declarationdate=[aa objectAtIndex:2];
           NSString *behalfvalue=[behalf valueForKey:@"Value"];
            NSString *declarationdatevalue=[declarationdate valueForKey:@"Value"];
            
            self.declarationCell.teenantSignatureTxt.text=signvalue;
            self.declarationCell.behalfTxt.text=behalfvalue;
            self.declarationCell.declarationDateTxt.text=declarationdatevalue;
            
            
         
            return declarationCell;
            
            
        }
        
        if (indexPath.section==7)
            
        {
            static NSString *futureIdentifier = @"FutureVisitsCell";
            [futureVisitCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            futureVisitCell = (FutureVisitsCell *)[self.tableView dequeueReusableCellWithIdentifier:futureIdentifier];
            if (self.futureVisitCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FutureVisitsCell" owner:self options:nil];
                self.futureVisitCell = [nib objectAtIndex:0];
            }
            
            NSDictionary *dict = [self.mainArray objectAtIndex:3];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:1];
            NSLog(@"ddd:%@",ddd);
            NSString *datevalue=[ddd valueForKey:@"Value"];
            self.futureVisitCell.futureDateTxt.text=datevalue;
            
            ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *futureRadiovalue=[ddd valueForKey:@"Value"];
            //future visits radio button
            for (int i = 0; i < 2; i ++) {
    
                UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [radioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [radioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                [radioButton setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:i]] forState:UIControlStateNormal];
                [radioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                radioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (i)
                {
                    [radioButton setFrame:CGRectMake(90, 60, 200, 44)];
                    if ([futureRadiovalue isEqualToString:@"NO"]) {
                        [radioButton setSelected:YES];
                    }
                    
                }
                else
                {
                    [radioButton setFrame:CGRectMake(-10, 60, 200, 44)];
                    if ([futureRadiovalue isEqualToString:@"YES"]) {
                       [radioButton setSelected:YES];
                    }
                    
                }
                [self.futureVisitRbArray addObject:radioButton];
                radioButton.tag=i;
            
            }
         
            [self.futureVisitCell addSubview:[futureVisitRbArray objectAtIndex:0]];
            [self.futureVisitCell addSubview:[futureVisitRbArray objectAtIndex:1]];
       
            self.futureVisitCell.futureDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.futureVisitCell.futureDateTxt.layer.borderWidth= 1.0f;
            self.futureVisitCell.futureDateTxt.userInteractionEnabled=NO;
           
            rect=  CGRectMake(50, 15, 660, 120);
            tempRefCell=self.futureVisitCell;
            [self createBorder];
     
             return futureVisitCell;
        
        }
        
        
        if (indexPath.section==8)
            
        {
            static NSString *insuranceIdentifier = @"InsuranceCell";
            [insuranceCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            insuranceCell = (InsuranceCell *)[self.tableView dequeueReusableCellWithIdentifier:insuranceIdentifier];
            if (self.insuranceCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InsuranceCell" owner:self options:nil];
                self.insuranceCell = [nib objectAtIndex:0];
            }
            
            
            self.insuranceCell.policyNoTxt.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.insuranceCell.policyNoTxt.layer.borderWidth= 1.0f;
            
            rect=  CGRectMake(55, 20, 670, 160);
            tempRefCell=self.insuranceCell;
            [self createBorder];
            
            self.insuranceCell.insranceDetailTxtView.layer.borderWidth = 1.0f;
            
            self.insuranceCell.insranceDetailTxtView.layer.borderColor = [[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f] CGColor];
            self.insuranceCell.insranceDetailTxtView.editable=NO;
            self.insuranceCell.policyNoTxt.userInteractionEnabled=NO;
         
            NSDictionary *dict = [self.mainArray objectAtIndex:4];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:1];
            NSLog(@"ddd:%@",ddd);
            NSString *policyvalue=[ddd valueForKey:@"Value"];
            NSMutableDictionary *detail=[aa objectAtIndex:2];
            NSString *insuranceDetailtxt=[detail valueForKey:@"Value"];
            self.insuranceCell.policyNoTxt.text=policyvalue;
            self.insuranceCell.insranceDetailTxtView.text=insuranceDetailtxt;
            
            ddd=[aa objectAtIndex:0];
            NSString *insuranceRadioValue=[ddd valueForKey:@"Value"];
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
                    if ([insuranceRadioValue isEqualToString:@"NO"]) {
                        [insuranceRadioButton setSelected:YES];
                    }
                    
                    
                }
                else{
                    [insuranceRadioButton setFrame:CGRectMake(0, 90, 200, 44)];
                    if ([insuranceRadioValue isEqualToString:@"YES"]) {
                        [insuranceRadioButton setSelected:YES];
                    }
                    
                }

                [self.insuranceRbArray addObject:insuranceRadioButton];
                insuranceRadioButton.tag=l;
            }

             [self.insuranceCell addSubview:[insuranceRbArray objectAtIndex:0]];
             [self.insuranceCell addSubview:[insuranceRbArray objectAtIndex:1]];
            
            return insuranceCell;
            
        }
        
        if (indexPath.section==9)
            
        {
            static NSString *inspectionIdentifier = @"InspectionCell";
            [inspectionCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            inspectionCell = (InspectionCell *)[self.tableView dequeueReusableCellWithIdentifier:inspectionIdentifier];
            if (self.inspectionCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InspectionCell" owner:self options:nil];
                self.inspectionCell = [nib objectAtIndex:0];
            }
  
            
            self.inspectionCell.inspectionDateTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.inspectionCell.inspectionDateTxt.layer.borderWidth= 1.0f;
            
            self.inspectionCell.inspectionTimeTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.inspectionCell.inspectionTimeTxt.layer.borderWidth= 1.0f;
            
            self.inspectionCell.presentTxt.layer.borderColor=[    [UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
            self.inspectionCell.presentTxt.layer.borderWidth= 1.0f;
            self.inspectionCell.inspectionDateTxt.userInteractionEnabled=NO;
            self.inspectionCell.inspectionTimeTxt.userInteractionEnabled=NO;
            self.inspectionCell.presentTxt.userInteractionEnabled=NO;
            
            rect=  CGRectMake(20, 15, 725, 120);
          tempRefCell=self.inspectionCell;
            [self createBorder];
            
            
            NSDictionary *dict = [self.mainArray objectAtIndex:6];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *inspectiondatevalue=[ddd valueForKey:@"Value"];
            self.inspectionCell.inspectionDateTxt.text=inspectiondatevalue;
            NSMutableDictionary *inspectionTime=[aa objectAtIndex:1];
             NSString *inspectiontimevalue=[inspectionTime valueForKey:@"Value"];
            
            self.inspectionCell.inspectionTimeTxt.text=inspectiontimevalue;
            
            NSMutableDictionary *present=[aa objectAtIndex:2];
            
               NSString *presentvalue=[present valueForKey:@"Value"];
              self.inspectionCell.presentTxt.text=presentvalue;
             return inspectionCell;
            
            
        }
    
    
      if (indexPath.section==10)
            
        {
            static NSString *finalIdentifier = @"FinalWordsCell";
            [finalCell setSelectionStyle:UITableViewCellSelectionStyleNone]; //for
            finalCell = (FinalWordsCell *)[self.tableView dequeueReusableCellWithIdentifier:finalIdentifier];
            if (self.finalCell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FinalWordsCell" owner:self options:nil];
                self.finalCell = [nib objectAtIndex:0];
            }
            
            NSDictionary *dict = [self.mainArray objectAtIndex:10];
            NSLog(@"dict:%@",dict);
            NSMutableArray *arr=[dict valueForKey:@"FieldGroups"];
            
            NSDictionary *di = [arr objectAtIndex:0];
            NSLog(@"di:%@",di);
            NSMutableArray *aa=[di valueForKey:@"Fields"];
            NSLog(@"aa:%@",aa);
            NSMutableDictionary *ddd=[aa objectAtIndex:0];
            NSLog(@"ddd:%@",ddd);
            NSString *deterioratedRadioValue=[ddd valueForKey:@"Value"];
            //final words radio button 1
            
            for (int j = 0; j < 2; j ++)
            {
                
                UIButton *finalradioButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [finalradioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                
                [finalradioButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                
                [finalradioButton setTitle:[NSString stringWithFormat:@"%@",[radioArray objectAtIndex:j]] forState:UIControlStateNormal];
                
                [finalradioButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
                finalradioButton.titleLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:17];
                
                if (j)
                    
                {
                    
                    [finalradioButton setFrame:CGRectMake(580, 23, 200, 44)];
                    if ([deterioratedRadioValue isEqualToString:@"NO"])
                    {
                        [finalradioButton setSelected:YES];
                        
                    }
                    
                }
                
                else
                {
                    
                    [finalradioButton setFrame:CGRectMake(490, 23, 200, 44)];
                    if ([deterioratedRadioValue isEqualToString:@"YES"]) {
                        [finalradioButton setSelected:YES];
                    }
                   
                }
                
                [self.finalwordsRbArray addObject:finalradioButton];
                
                finalradioButton.tag=j;
                
            }
            
            ddd=[aa objectAtIndex:1];
            NSLog(@"ddd:%@",ddd);
            NSString *conditionRadioValue=[ddd valueForKey:@"Value"];
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
                    if ([conditionRadioValue isEqualToString:@"NO"]) {
                        [finalradioButtontwo setSelected:YES];
                    }
                    
                }
                
                else{
                    
                    [finalradioButtontwo setFrame:CGRectMake(490, 75, 200, 44)];
                    
                    if ([conditionRadioValue isEqualToString:@"YES"]) {
                        [finalradioButtontwo setSelected:YES];
                    }
                    
                }
                
                
                [self.finalwordsRbArray2 addObject:finalradioButtontwo];
                
                finalradioButtontwo.tag=k;
                
            }

            [self.finalCell addSubview:[finalwordsRbArray objectAtIndex:0]];
            [self.finalCell addSubview:[finalwordsRbArray objectAtIndex:1]];
            
            [self.finalCell addSubview:[finalwordsRbArray2 objectAtIndex:0]];
            [self.finalCell addSubview:[finalwordsRbArray2 objectAtIndex:1]];
            
            rect=  CGRectMake(30, 20, 710, 100);
            
            tempRefCell=self.finalCell;
            [self createBorder];
   
            
            return finalCell;
            
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
    return 1;
    //return mainArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PastFormsView *pastformVC=[[PastFormsView alloc]initWithNibName:@"PastFormsView" bundle:nil];
    //[self.navigationController pushViewController:pastformVC animated:YES];
 
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    static NSString *ChildCellIdentifier = @"HeaderCell";
    
    self.headerCell=(HeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:ChildCellIdentifier];
    
    if (self.headerCell==nil) {
        
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HeaderCell" owner:self options:nil];
        self.headerCell=[nib objectAtIndex:0];
        
    }
    self.headerCell.backgroundColor=[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    self.headerCell.headerTitleLbl.textColor=[UIColor whiteColor];
    self.headerCell.headerTitleLbl.text=[self.titleArray objectAtIndex:section];
    return headerCell;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
return 60;
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

@end
