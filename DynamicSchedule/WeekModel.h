//
//  WeekModel.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayModel.h"

@interface WeekModel : DayModel

@property (nonatomic, strong) NSString *dayStr;
@property (nonatomic, assign) int dayNum;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, assign) BOOL isBlack;
@property (nonatomic, strong) NSArray *dayModels;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
