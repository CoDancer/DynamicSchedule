//
//  ExpandModel.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/10.
//  Copyright © 2016年 CoDancer. All rights reserved.
//
//                       2
//                       |
//                       |
//适配动画     3 <---（1，2，3，4）---> 1
//                       |
//                       |
//                       4
//说明：当四个View的center在相同的一个点时，接着需要在0.8s的时间中这四个view分别运动到1，2，3，4这位置上。

//                       2
//                       |
//                       |
//适配动画     3 --->（1，2，3，4）<--- 1
//                       |
//                       |
//                       4
//说明：四个视图的收缩

//                                        (1视图到新的位置)
//                       2               /
//                       |              /
//                       |             /
//适配动画     3 ---》（1，2，3，4）--- 1(点击)
//                       |
//                       |
//                       4
//说明：点击1后，1移动到新的位置而234分别到center

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExpandModel : NSObject

+ (void)expandToNewCenterWithViews:(NSArray *)viewArr
                        andCenterP:(CGPoint)p;

+ (void)drawBackNewCenterWithViews:(NSArray *)viewArr
                        andCenterP:(CGPoint)p;

+ (void)clickView:(UIButton *)selectBtn
        inViewArr:(NSArray *)viewArr
         withOffY:(CGFloat)y;

@end
