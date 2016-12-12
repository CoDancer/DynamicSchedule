//
//  DynamicWeekView.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekModel.h"

typedef void(^SwipeBlock)(WeekModel *model);

@interface DynamicWeekView : UICollectionView

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) SwipeBlock swipeBlock;

@end
