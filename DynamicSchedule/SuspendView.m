//
//  SuspendView.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "SuspendView.h"
#import "UIView+Category.h"
#import "GlobalModel.h"

@interface SuspendView()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *dayStrLabel;
@property (nonatomic, strong) UILabel *dayNumLabel;
@property (nonatomic, strong) UILabel *monthLabel;

@end

@implementation SuspendView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dotView];
        [self addSubview:self.dayStrLabel];
        [self addSubview:self.dayNumLabel];
        [self addSubview:self.monthLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.dotView.size = CGSizeMake(5, 5);
    self.dotView.layer.cornerRadius = self.dotView.width/2.0;
    self.dotView.clipsToBounds = YES;
    self.dotView.top = 0;
    self.dotView.centerX = self.width/2.0;
    
    [self.dayStrLabel sizeToFit];
    self.dayStrLabel.top = 20;
    self.dayStrLabel.centerX = self.dotView.centerX;
    
    [self.dayNumLabel sizeToFit];
    self.dayNumLabel.top = self.dayStrLabel.bottom;
    self.dayNumLabel.centerX = self.dayStrLabel.centerX;
    
    [self.monthLabel sizeToFit];
    self.monthLabel.top = self.dayNumLabel.bottom;
    self.monthLabel.centerX = self.dayNumLabel.centerX;
}

- (UIView *)dotView {
    
    if (!_dotView) {
        _dotView = [UIView new];
        _dotView.backgroundColor = [UIColor whiteColor];
    }
    return _dotView;
}

- (UILabel *)dayStrLabel {
    
    if (!_dayStrLabel) {
        _dayStrLabel = [UILabel new];
        [_dayStrLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [_dayStrLabel setTextColor:[UIColor whiteColor]];
    }
    return _dayStrLabel;
}

- (UILabel *)dayNumLabel {
    
    if (!_dayNumLabel) {
        _dayNumLabel = [UILabel new];
        [_dayNumLabel setFont:[UIFont systemFontOfSize:55.0f]];
        [_dayNumLabel setTextColor:[UIColor whiteColor]];
    }
    return _dayNumLabel;
}

- (UILabel *)monthLabel {
    
    if (!_monthLabel) {
        _monthLabel = [UILabel new];
        [_monthLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_monthLabel setTextColor:[UIColor whiteColor]];
    }
    return _monthLabel;
}

- (void)setModel:(WeekModel *)model {
    
    _model = model;
    self.dayStrLabel.text = model.dayStr;
    self.dayNumLabel.text = [NSString stringWithFormat:@"%d",model.dayNum];
    self.monthLabel.text  = model.month;
    [self.dayNumLabel sizeToFit];
    [self.dayStrLabel sizeToFit];
    [self.monthLabel sizeToFit];
}


@end
