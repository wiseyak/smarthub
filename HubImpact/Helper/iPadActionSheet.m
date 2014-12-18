//
//  iPadActionSheet.m
//  HubImpact
//
//  Created by Prakash Maharjan on 17/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//


#import "iPadActionSheet.h"
#import "Constants.h"
#import "AppDelegate.h"


@interface iPadActionSheet ()

@end

@implementation iPadActionSheet

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)promptToShare:(id)sender {
    UIButton * btn = (UIButton *) sender;
    [APP_DEL.popUp dismissPopoverAnimated:YES];
    [self.delegate promptToShareOfType:btn.tag];
}

@end
