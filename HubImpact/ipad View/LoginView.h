//
//  LoginView.h
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
@class MBProgressHUD;

@interface LoginView : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate>

- (IBAction)loginBtnTapped:(id)sender;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong) ASIFormDataRequest *loginrequest;
@property(nonatomic,strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UISwitch *settingSwitch;
@end
