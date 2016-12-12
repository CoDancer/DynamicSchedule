//
//  DayScheduleTabView.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayScheduleCell;
typedef void(^CellSelectBlock)(DayScheduleCell *cell, CGFloat contentOffY);

@interface DayScheduleTabView : UITableView

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) CellSelectBlock selectBlock;


@end
