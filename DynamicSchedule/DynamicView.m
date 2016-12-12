//
//  DynamicView.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/10.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "DynamicView.h"
#import "UIView+Category.h"
#import "GlobalModel.h"
#import "ExpandModel.h"
#import "DayScheduleCell.h"

@interface DynamicView()

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) NSArray *logoBtnArr;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation DynamicView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:MAINSCREEN];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        _coverView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(coverViewDidTap)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (CAShapeLayer *)circleLayer {
    
    if (!_circleLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH/2.0,
                                                                               SCREEN_HEIGHT*2/3)
                                                            radius:SCREEN_WIDTH/4.0
                                                        startAngle:-360
                                                          endAngle:0.01
                                                         clockwise:YES];
        
        // 底色
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.zPosition = 1;
        _circleLayer.frame = self.bounds;
        _circleLayer.fillColor = [[UIColor clearColor] CGColor];
        _circleLayer.strokeColor = [[UIColor clearColor] CGColor];
        _circleLayer.opacity = 1.0;
        _circleLayer.lineCap = kCALineCapRound;
        _circleLayer.lineWidth = 2.0f;
        _circleLayer.path = [path CGPath];
    }
    return _circleLayer;
}

- (void)coverViewDidTap {
    
    [self dismiss];
}

- (void)dismiss {
    
    [self dynamicDrawBackAnimation];
}

- (void)setPicArr:(NSArray *)picArr {
    
    _picArr = picArr;
    [self addSubview:self.coverView];
    NSMutableArray *btnArr = [NSMutableArray array];
    [picArr enumerateObjectsUsingBlock:^(NSString *picStr, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *contactBtn = [UIButton new];
        contactBtn.layer.zPosition = 2;
        contactBtn.tag = idx + 2;
        [contactBtn addTarget:self
                       action:@selector(contactBtnDidTouch:)
             forControlEvents:UIControlEventTouchUpInside];
        contactBtn.size = CGSizeMake(50, 50);
        [contactBtn setImage:[UIImage imageNamed:picStr]
                   forState:UIControlStateNormal];
        contactBtn.layer.cornerRadius = contactBtn.width/2.0;
        contactBtn.clipsToBounds = YES;
        contactBtn.layer.borderColor = [UIColor yellowColor].CGColor;
        contactBtn.layer.borderWidth = 2.0f;
        contactBtn.center = CGPointMake(SCREEN_WIDTH/2.0, 2*SCREEN_HEIGHT/3.0);
        contactBtn.hidden = YES;
        [btnArr addObject:contactBtn];
        [self addSubview:contactBtn];
    }];
    self.logoBtnArr = [btnArr copy];
    UIButton *centerBtn = [UIButton new];
    centerBtn.layer.zPosition = 3;
    centerBtn.tag = 1;
    centerBtn.size = CGSizeMake(50, 50);
    [centerBtn setImage:[UIImage imageNamed:@"FireLogo.jpg"]
               forState:UIControlStateNormal];
    centerBtn.layer.cornerRadius = centerBtn.width/2.0;
    centerBtn.clipsToBounds = YES;
    centerBtn.top = SCREEN_HEIGHT;
    centerBtn.centerX = SCREEN_WIDTH/2.0;
    [self addSubview:centerBtn];
}

- (void)dynamicExpandAnimation {
    
    UIButton *centerBtn = (UIButton *)[self viewWithTag:1];
    [self.layer addSublayer:self.circleLayer];
    //类似帧动画
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.coverView.alpha = 0.4;
        centerBtn.center = CGPointMake(SCREEN_WIDTH/2.0, 2*SCREEN_HEIGHT/3.0);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            [ExpandModel expandToNewCenterWithViews:self.logoBtnArr andCenterP:centerBtn.center];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.circleLayer setStrokeColor:[UIColor yellowColor].CGColor];
            }];
        }];
        
    }];
}

- (void)dynamicDrawBackAnimation {
    
    UIButton *centerBtn = (UIButton *)[self viewWithTag:1];
    //类似帧动画
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        
        self.circleLayer.strokeColor = [UIColor clearColor].CGColor;
        [ExpandModel drawBackNewCenterWithViews:self.logoBtnArr andCenterP:centerBtn.center];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^ {
            self.coverView.alpha = 0.0;
            if (self.dismissBlock) {
                self.dismissBlock();
            }
            centerBtn.top = SCREEN_HEIGHT;
            [self.logoBtnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            [self.coverView removeFromSuperview];
            [self.circleLayer removeFromSuperlayer];
            self.circleLayer = nil;
        }];
    }];
}

- (void)clickViewAnimationWithBtn:(UIButton *)select
                             andY:(CGFloat)y
                     scheduleCell:(DayScheduleCell *)cell {
    
    UIButton *centerBtn = (UIButton *)[self viewWithTag:1];
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.circleLayer.strokeColor = [UIColor clearColor].CGColor;
        [ExpandModel clickView:select inViewArr:self.logoBtnArr withOffY:y];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            self.coverView.alpha = 0.0;
            if (self.dismissBlock) {
                self.dismissBlock();
            }
            centerBtn.top = SCREEN_HEIGHT;
            [cell showLogoViewWithPic:select.imageView.image];
            [self.logoBtnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.coverView removeFromSuperview];
            [self.circleLayer removeFromSuperlayer];
            self.circleLayer = nil;
        }];
    }];
}

- (void)removeViewFromSelf {
    
    
}

- (void)addViewOnView:(UIView *)view {
    
    
}

- (void)contactBtnDidTouch:(UIButton *)sender {
    
    if (self.clickBlock) {
        self.clickBlock(sender);
    }
}



@end