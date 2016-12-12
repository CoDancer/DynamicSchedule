//
//  DayModel.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayModel : NSObject

@property (nonatomic, strong) NSString *dayThing;
@property (nonatomic, strong) NSString *timeStr;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
