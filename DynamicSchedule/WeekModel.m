//
//  WeekModel.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "WeekModel.h"

@implementation WeekModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.dayStr = [dic objectForKey:@"dayStr"];
        self.dayNum = [[dic objectForKey:@"dayNum"] intValue];
        self.month  = [dic objectForKey:@"month"];
        self.isBlack = [[dic objectForKey:@"isBlack"] boolValue];
        
        NSArray *dayThings = [dic objectForKey:@"dayThings"];
        NSMutableArray *dayModels = [NSMutableArray array];
        [dayThings enumerateObjectsUsingBlock:^(NSDictionary *obj,
                                                NSUInteger idx, BOOL * _Nonnull stop) {
            DayModel *dayModel = [[DayModel alloc] initWithDic:obj];
            [dayModels addObject:dayModel];
        }];
        self.dayModels = [dayModels copy];
    }
    return self;
}



@end
