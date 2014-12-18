//
//  cleanVC.h
//  HubImpact
//
//  Created by One Platinum on 12/4/14.
//  Copyright (c) 2014 Design Offshore Nepal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cleanVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int num;

}

@property (weak, nonatomic) IBOutlet UITableView *MytableView;
@property(nonatomic,strong)NSMutableArray *recipes;
@end
