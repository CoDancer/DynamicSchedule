//
//  DayScheduleTabView.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/9.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "DayScheduleTabView.h"
#import "DayScheduleCell.h"

@interface DayScheduleTabView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *idxArr;

@end

@implementation DayScheduleTabView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate   = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self registerClass:[DayScheduleCell class] forCellReuseIdentifier:@"ScheduleCell"];
    return self;
}

- (NSMutableArray *)idxArr {
    
    if (!_idxArr) {
        _idxArr = [NSMutableArray array];
    }
    return _idxArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DayScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell"
                                                            forIndexPath:indexPath];
    DayModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DayScheduleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.selectBlock) {
        self.selectBlock(cell, tableView.contentOffset.y);
    }
    NSLog(@"%@",NSStringFromCGRect(cell.bounds));
    [self.idxArr addObject:@(indexPath.row)];
    [cell cellSelectedState];
    if ([self.idxArr count] != 1 &&
        [[self.idxArr firstObject] integerValue] != [[self.idxArr lastObject] integerValue]) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[[self.idxArr firstObject] integerValue] inSection:0];
        DayScheduleCell *lastCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        [lastCell resetCellState];
        [self.idxArr removeObjectAtIndex:0];
    }
}


@end
