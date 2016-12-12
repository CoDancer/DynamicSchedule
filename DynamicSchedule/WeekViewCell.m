//
//  WeekViewCellCollectionViewCell.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "WeekViewCell.h"
#import "UIView+Category.h"
#import "GlobalModel.h"

@interface WeekViewCell()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation WeekViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dayLabel];
        [self addSubview:self.numLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.dayLabel sizeToFit];
    self.dayLabel.top = 20;
    self.dayLabel.centerX = self.width/2.0;
    [self.numLabel sizeToFit];
    self.numLabel.top = self.dayLabel.bottom;
    self.numLabel.centerX = self.dayLabel.centerX;
}

- (UILabel *)dayLabel {
    
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.font = [UIFont systemFontOfSize:17.0f];
        _dayLabel.textColor = NUMLABELTEXT_COLOR;
    }
    return _dayLabel;
}

- (UILabel *)numLabel {
    
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont systemFontOfSize:60.0f];
        _numLabel.textColor = NUMLABELTEXT_COLOR;
    }
    return _numLabel;
}

- (void)setModel:(WeekModel *)model {
    
    _model = model;
    if (model.isBlack) {
        self.backgroundColor = WEEKBG_COLOR;
    }else {
        self.backgroundColor = LIGHTGRAY_COLOR;
    }
    self.dayLabel.text = model.dayStr;
    self.numLabel.text = [NSString stringWithFormat:@"%d",model.dayNum];
    [self.dayLabel sizeToFit];
    [self.numLabel sizeToFit];
}

@end
