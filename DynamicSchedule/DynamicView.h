//
//  DynamicView.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/10.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayScheduleCell;

typedef void(^DismissBlock)();
typedef void(^BtnClickBlock)(UIButton *selectBtn);

@interface DynamicView : UIView

@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic, strong) DismissBlock dismissBlock;
@property (nonatomic, strong) BtnClickBlock clickBlock;

- (void)dynamicExpandAnimation;
- (void)clickViewAnimationWithBtn:(UIButton *)select
                             andY:(CGFloat)y
                     scheduleCell:(DayScheduleCell *)cell;

@end
