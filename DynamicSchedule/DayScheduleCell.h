//
//  DayScheduleCell.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayModel.h"

@interface DayScheduleCell : UITableViewCell

@property (nonatomic, strong) DayModel *model;

- (void)cellSelectedState;
- (void)resetCellState;

- (void)showLogoViewWithPic:(UIImage *)img;

@end
