//
//  GlobalModel.h
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAINSCREEN [UIScreen mainScreen].bounds
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define WEEKBG_COLOR RGB(24,33,41)
#define NUMLABELTEXT_COLOR RGB(53,66,78)
#define YELLOW_COLOR RGB(232,214,46)
#define LIGHTGRAY_COLOR RGB(41,49,57)
#define TOPBG_COLOR RGB(41,41,49)
#define SUSPEND_COLOR RGB(99,117,138)
#define CELL_COLOR RGB(49,57,66)
#define LINE_COLOR RGB(57,67,83)

#define k_IOS_Scale [[UIScreen mainScreen] bounds].size.width/320
#define k_IOSV_Scale [[UIScreen mainScreen] bounds].size.height/568

@interface GlobalModel : NSObject

@end
