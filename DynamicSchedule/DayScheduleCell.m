//
//  DayScheduleCell.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "DayScheduleCell.h"
#import "GlobalModel.h"
#import "UIView+Category.h"

@interface DayScheduleCell()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *scheduleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowIV;

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation DayScheduleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = CELL_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.scheduleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.dotView];
        
        [self.contentView addSubview:self.logoView];
        [self.contentView addSubview:self.arrowIV];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.lineView.size = CGSizeMake(3, self.contentView.height);
    self.lineView.left = 10;
    self.lineView.top = 0;
    
    self.dotView.size = CGSizeMake(6, 6);
    self.dotView.layer.cornerRadius = self.dotView.width/2.0;
    self.dotView.clipsToBounds = YES;
    self.dotView.layer.borderColor  = CELL_COLOR.CGColor;
    self.dotView.layer.borderWidth = 1.f;
    self.dotView.centerX = self.lineView.centerX;
    self.dotView.centerY = self.contentView.height/2.0;
    
    [self.scheduleLabel sizeToFit];
    self.scheduleLabel.centerY = self.dotView.centerY;
    self.scheduleLabel.left = self.dotView.right + 15;
    
    [self.timeLabel sizeToFit];
    self.timeLabel.left = self.scheduleLabel.left;
    self.timeLabel.top  = self.scheduleLabel.bottom;
    
    [self.arrowIV sizeToFit];
    self.arrowIV.centerY = self.scheduleLabel.centerY;
    self.arrowIV.right = self.contentView.width - 10;
    
    self.logoView.size = CGSizeMake(50, 50);
    self.logoView.layer.cornerRadius = self.logoView.width/2.0;
    self.logoView.clipsToBounds = YES;
    self.logoView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.logoView.layer.borderWidth = 2.0f;
    self.logoView.centerX = self.contentView.width - 40;
    self.logoView.centerY = self.contentView.height/2.0;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.width/2.0,
                                                               self.contentView.height/2.0, 0, 0)];
        _bottomView.backgroundColor = [UIColor yellowColor];
        _bottomView.alpha = 0;
    }
    return _bottomView;
}

- (UILabel *)scheduleLabel {
    
    if (!_scheduleLabel) {
        _scheduleLabel = [UILabel new];
        [_scheduleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        _scheduleLabel.textColor = [UIColor whiteColor];
    }
    return _scheduleLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        [_timeLabel setFont:[UIFont systemFontOfSize:14.0f]];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}

- (UIView *)dotView {
    
    if (!_dotView) {
        _dotView = [UIView new];
        _dotView.backgroundColor = [UIColor yellowColor];
    }
    return _dotView;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LINE_COLOR;
        _lineView.alpha = 0.6;
    }
    return _lineView;
}

- (UIImageView *)arrowIV {
    
    if (!_arrowIV) {
        _arrowIV = [UIImageView new];
        _arrowIV.image = [UIImage imageNamed:@"gen_arrow_yellow"];
    }
    return _arrowIV;
}

- (UIImageView *)logoView {
    
    if (!_logoView) {
        _logoView = [UIImageView new];
        _logoView.hidden = YES;
    }
    return _logoView;
}

- (void)setModel:(DayModel *)model {
    
    _model = model;
    self.scheduleLabel.text = model.dayThing;
    self.timeLabel.text     = model.timeStr;
    self.logoView.hidden = YES;
    self.arrowIV.hidden = NO;
    [self.scheduleLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
}

- (void)cellSelectedState {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8
          initialSpringVelocity:0 options:0 animations:^{
              self.bottomView.frame = self.contentView.bounds;
              self.bottomView.alpha = 0.8;
          } completion:nil];
    self.scheduleLabel.textColor = CELL_COLOR;
}

- (void)resetCellState {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8
          initialSpringVelocity:0 options:0 animations:^{
              self.bottomView.frame = CGRectMake(self.contentView.width/2.0,
                                                 self.contentView.height/2.0, 0, 0);
              self.bottomView.alpha = 0;
          } completion:nil];
    self.scheduleLabel.textColor = [UIColor whiteColor];
}

- (void)showLogoViewWithPic:(UIImage *)img {
    
    self.logoView.image = img;
    self.logoView.hidden = NO;
    self.arrowIV.hidden = YES;
}

@end
