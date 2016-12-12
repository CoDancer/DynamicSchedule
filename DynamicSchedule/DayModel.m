//
//  DayModel.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "DayModel.h"

@implementation DayModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.dayThing = [dic objectForKey:@"thing"];
        self.timeStr  = [dic objectForKey:@"time"];
    }
    return self;
}

@end
