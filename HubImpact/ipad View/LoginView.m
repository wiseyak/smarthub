//
//  LoginView.m
//  HubImpact
//
//  Created by Prakash Maharjan on 29/10/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import "LoginView.h"
#import "AddNewFormVC.h"
#import "PreviewPastFormView.h"
#import "MBProgressHUD.h"
#import "Helper.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Constants.h"
@interface LoginView ()

@end

@implementation LoginView
@synthesize tabBarController;
@synthesize emailTxtField,
passwordTxtField;
@synthesize loginBtn;
@synthesize hud;
@synthesize settingSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.loginBtn.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f];

    self.loginBtn.layer.cornerRadius=6.0f;
    
    self.emailTxtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    self.emailTxtField.layer.borderWidth= 1.0f;
    //self.emailTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0);
    
    self.emailTxtField.layer.cornerRadius=3.0f;
    self.emailTxtField.clipsToBounds=YES;
    
    UIView *usernameleftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 5)];
    usernameleftView.backgroundColor = [UIColor clearColor];
    self.emailTxtField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTxtField.leftView = usernameleftView;
    /*
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    [self.emailTxtField setLeftViewMode:UITextFieldViewModeAlways];
    [self.emailTxtField setLeftView:spacerView];
    
//
    
//
    UIView *pwdspace = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    [self.passwordTxtField setLeftViewMode:UITextFieldViewModeAlways];
    [self.passwordTxtField setLeftView:pwdspace];
     */
    self.passwordTxtField.layer.borderColor=[[UIColor colorWithRed:239.0f/255.0f green:238.0f/255.0f blue:243.0f/255.0f alpha:1.0f]CGColor];
    self.passwordTxtField.layer.borderWidth= 1.0f;
     self.passwordTxtField.layer.cornerRadius=3.0f;
    self.passwordTxtField.clipsToBounds=YES;
    
    UIView *pwdleftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 5)];
    pwdleftView.backgroundColor = [UIColor clearColor];
    self.passwordTxtField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxtField.leftView = pwdleftView;
    
    
    //[self.passwordTxtField setLeftViewMode:UITextFieldViewModeAlways];
   // [self.passwordTxtField setLeftView:spacerView];
     // self.passwordTxtField.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0);
    
    //switch setting
    [self.settingSwitch setOnTintColor:[UIColor colorWithRed:102.0f/255.0f green:90.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    settingSwitch.on = [defaults boolForKey: K_SWITCH_KEY];
    
    NSString *userID = [defaults objectForKey:@"userID"];
    NSString *password = [defaults objectForKey:@"password"];
    
    self.emailTxtField.text=userID;
    self.passwordTxtField.text=password;

    

}
-(void)viewWillAppear:(BOOL)animated{
    //switch setting
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    settingSwitch.on = [defaults boolForKey: K_SWITCH_KEY];
    
    NSString *userID = [defaults objectForKey:@"userID"];
    NSString *password = [defaults objectForKey:@"password"];
    
    self.emailTxtField.text=userID;
    self.passwordTxtField.text=password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtnTapped:(id)sender {
    [self.emailTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
    [self requestLogin];

/*
    //encoding
    NSString *plainString=@"naresh:nthapa13";
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"encoded string::%@", base64String); 
   
    
    //Decoding
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"decoded string::%@", decodedString);
   */
}


-(void)dismissKeyboard{
    [self.emailTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
    
}
-(void)test{
    
}
-(void)tabIndexSet:(int)index
{
    NSLog(@"intvalue:%d",index);
   self.tabBarController.selectedIndex=index;
}


-(void)requestLogin{
     //encoding
    NSString *userinfo=[NSString stringWithFormat:@"%@:%@",self.emailTxtField.text,self.passwordTxtField.text];
    //NSString *plainString=@"naresh:nthapa13";
    NSData *plainData = [userinfo dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSString *basic = @"Basic ";
    NSString *finalString = [basic stringByAppendingString:base64String];
    NSString *sendingInfo=[NSString stringWithFormat:@"username=%@&password=%@&scope=admin&grant_type=password",self.emailTxtField.text,self.passwordTxtField.text];
    NSData *data = [sendingInfo dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"encoded string::%@", base64String);
    
    NSString *URL=[NSString stringWithFormat:@"http://182.93.95.189/TheHubAuth/oauth/token"];
    
    NSString *fixedURL = [URL
                          stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:fixedURL];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Authorization" value:finalString];
    [request setPostBody:[NSMutableData dataWithData:data]];
    [request setDelegate:self];
    [request startAsynchronous];

}

-(void)requestStarted:(ASIHTTPRequest *)request{
    [self showhud];
}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    [self hidehud];
    NSString *responseString = [request responseString];
    
    
    NSLog(@"*****response::::::::::%@",responseString);
    NSMutableDictionary *dict=[responseString JSONValue];
    NSString *token=[dict valueForKey:@"access_token"];
    if (!token.length==0)
    {
        NSString *accessToken = [dict valueForKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.emailTxtField.text forKey:@"loggedInUserName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *saveduserID =self.emailTxtField.text;
        NSString *savedpassword=self.passwordTxtField.text;
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:saveduserID forKey:@"loginuserID"];
        [defaults setObject:savedpassword forKey:@"loginpassword"];
        [defaults synchronize];
        
        
        if (settingSwitch.on)
        {
            NSString *userID =self.emailTxtField.text;
            NSString *password =self.passwordTxtField.text;
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool: settingSwitch.on forKey: K_SWITCH_KEY];
            [defaults setObject:userID forKey:@"userID"];
            [defaults setObject:password forKey:@"password"];
            [defaults synchronize];
            
        }
        else if (!settingSwitch.on)
        {
            NSString *userID =@"";
            NSString *password =@"";
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool: settingSwitch.on forKey: K_SWITCH_KEY];
            
            [defaults setObject:userID forKey:@"userID"];
            [defaults setObject:password forKey:@"password"];
            [defaults synchronize];
        }
        

        
        //self.emailTxtField.text=@"";
       // self.passwordTxtField.text=@"";
                AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
         [appDelegate createTabbar];
   
    }
    else{
  
        [self notifyErrorMessage:[dict valueForKey:@"error"]];

    }
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [self hidehud];
    NSError *error = [request error];
    
    NSLog(@"request:*****%@",error.localizedDescription);
    [self notifyErrorMessage:error.localizedDescription];
    
}


#pragma mark hudactions

-(void)showhud{
    self.hud=[Helper getHudforview:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelFont = [UIFont boldSystemFontOfSize:12.0f];
    self.hud.labelText=@"Please Wait..";
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


@end
