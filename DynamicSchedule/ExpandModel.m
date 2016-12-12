//
//  ExpandModel.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/10.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "ExpandModel.h"
#import "GlobalModel.h"
#import "UIView+Category.h"

#define Radius SCREEN_WIDTH/4.0

@implementation ExpandModel

+ (void)expandToNewCenterWithViews:(NSArray *)viewArr
                        andCenterP:(CGPoint)p {
    
    if (viewArr.count == 4) {
        [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = NO;
            if (idx == 0) {
                obj.center = CGPointMake(obj.centerX + Radius, obj.centerY);
            }else if (idx == 1) {
                obj.center = CGPointMake(obj.centerX, obj.centerY - Radius);
            }else if (idx == 2) {
                obj.center = CGPointMake(obj.centerX - Radius, obj.centerY);
            }else if (idx == 3) {
                obj.center = CGPointMake(obj.centerX, obj.centerY + Radius);
            }
        }];
    }
}

+ (void)drawBackNewCenterWithViews:(NSArray *)viewArr andCenterP:(CGPoint)p {
    
    if (viewArr.count == 4) {
        [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                obj.center = CGPointMake(obj.centerX - Radius, obj.centerY);
            }else if (idx == 1) {
                obj.center = CGPointMake(obj.centerX, obj.centerY + Radius);
            }else if (idx == 2) {
                obj.center = CGPointMake(obj.centerX + Radius, obj.centerY);
            }else if (idx == 3) {
                obj.center = CGPointMake(obj.centerX, obj.centerY - Radius);
            }
        }];
    }
}

+ (void)clickView:(UIButton *)selectBtn
        inViewArr:(NSArray *)viewArr
         withOffY:(CGFloat)y {
    
    if (viewArr.count == 4) {
        if (selectBtn.tag == 2) {
            [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    obj.center = CGPointMake(SCREEN_WIDTH - 40, y);
                }else if (idx == 1) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY + Radius);
                }else if (idx == 2) {
                    obj.center = CGPointMake(obj.centerX + Radius, obj.centerY);
                }else if (idx == 3) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY - Radius);
                }
                
            }];
        }else if (selectBtn.tag == 3) {
            [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    obj.center = CGPointMake(obj.centerX - Radius, obj.centerY);
                }else if (idx == 1) {
                    obj.center = CGPointMake(SCREEN_WIDTH - 40, y);
                }else if (idx == 2) {
                    obj.center = CGPointMake(obj.centerX + Radius, obj.centerY);
                }else if (idx == 3) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY - Radius);
                }
                
            }];
        }else if (selectBtn.tag == 4) {
            [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    obj.center = CGPointMake(obj.centerX - Radius, obj.centerY);
                }else if (idx == 1) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY + Radius);
                }else if (idx == 2) {
                    obj.center = CGPointMake(SCREEN_WIDTH - 40, y);
                }else if (idx == 3) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY - Radius);
                }
                
            }];
        }else if (selectBtn.tag == 5) {
            [viewArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    obj.center = CGPointMake(obj.centerX - Radius, obj.centerY);
                }else if (idx == 1) {
                    obj.center = CGPointMake(obj.centerX, obj.centerY + Radius);
                }else if (idx == 2) {
                    obj.center = CGPointMake(obj.centerX + Radius, obj.centerY);;
                }else if (idx == 3) {
                    obj.center = CGPointMake(SCREEN_WIDTH - 40, y);
                }
                
            }];
        }
        
    }
}

@end
