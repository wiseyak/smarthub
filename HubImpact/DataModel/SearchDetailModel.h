//
//  SearchDetailModel.h
//  HubImpact
//
//  Created by Prakash Maharjan on 12/11/2014.
//  Copyright (c) 2014 Prakash Maharjan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDetailModel : NSObject
@property(nonatomic,strong) NSString *datatype;
@property(nonatomic,strong) NSString *displayLabel;
@property(nonatomic,strong) NSString *displayOrder;
@property(nonatomic,strong) NSString *fieldname;
@property(nonatomic,strong) NSString *isrequired;
@property(nonatomic,strong) NSString *value;

@end

