//
//  ViewController.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "ViewController.h"
#import "DynamicWeekView.h"
#import "WeekModel.h"
#import "GlobalModel.h"
#import "UIView+Category.h"
#import "UIColor+Extensions.h"
#import "SuspendView.h"
#import "DayScheduleTabView.h"
#import "DynamicView.h"
#import "DayScheduleCell.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) DynamicWeekView *weekView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) SuspendView *suspendView;
@property (nonatomic, strong) DayScheduleTabView *tableView;
@property (nonatomic, strong) DynamicView *dynamicView;
@property (nonatomic, strong) WeekModel *model;

@property (nonatomic, strong) DayScheduleCell *scheduleCell;
@property (nonatomic, assign) CGFloat contentOffY;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = TOPBG_COLOR;
    [self getLocalData];
    [self configView];
}

- (void)getLocalData {

    NSArray *localDataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                      pathForResource:@"WeekData"
                                      ofType:@"plist"]];
    NSMutableArray *dataArray = [NSMutableArray array];
    [localDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WeekModel *model = [[WeekModel alloc] initWithDic:obj];
        [dataArray addObject:model];
    }];
    self.dataArr = [dataArray copy];
    self.model   = [self.dataArr objectAtIndex:2];
}

- (void)configView {

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.suspendView];
    [self.view addSubview:self.topView];
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        _topView.layer.shadowColor = [UIColor blackColor].CGColor;
        _topView.layer.shadowOffset = CGSizeMake(4, 8);
        _topView.layer.shadowOpacity = 0.8;
        _topView.layer.shadowRadius = 4;
        _topView.backgroundColor = TOPBG_COLOR;
        _topView.layer.zPosition = 3;
        UIImageView *logoIV = [UIImageView new];
        logoIV.size = CGSizeMake(28, 36);
        logoIV.backgroundColor = [UIColor clearColor];
        logoIV.image = [UIImage imageNamed:@"yellowLogo"];
        logoIV.centerX = SCREEN_WIDTH/2.0;
        logoIV.centerY = _topView.height/2.0;
        [_topView addSubview:logoIV];
    }
    return _topView;
}

- (SuspendView *)suspendView {
    
    if (!_suspendView) {
        _suspendView = [[SuspendView alloc]
                            initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5.0, 130)];
        _suspendView.top = self.topView.bottom;
        _suspendView.centerX = self.topView.centerX;
        _suspendView.layer.shadowColor = [UIColor blackColor].CGColor;
        _suspendView.layer.shadowOffset = CGSizeMake(-4, 8);
        _suspendView.layer.shadowOpacity = 0.8;
        _suspendView.layer.shadowRadius = 4;
        _suspendView.backgroundColor = SUSPEND_COLOR;
        _suspendView.layer.zPosition = 2;
        WeekModel *model = [self.dataArr objectAtIndex:2];
        _suspendView.model = model;
    }
    return _suspendView;
}

- (DynamicWeekView *)weekView {
    
    if (!_weekView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5.0, 120);
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _weekView = [[DynamicWeekView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, 120) collectionViewLayout:layout];
        _weekView.layer.shadowColor = [UIColor blackColor].CGColor;
        _weekView.layer.shadowOffset = CGSizeMake(4, 8);
        _weekView.layer.shadowOpacity = 0.8;
        _weekView.layer.shadowRadius = 4;
        _weekView.layer.zPosition = 1;
        _weekView.dataArr = self.dataArr;
        __weak typeof(self) weakSelf = self;
        _weekView.swipeBlock = ^(WeekModel *model){
            weakSelf.model = model;
            weakSelf.suspendView.model = model;
            weakSelf.tableView.dataArr = model.dayModels;
            [weakSelf.tableView reloadData];
        };
    }
    return _weekView;
}

- (DayScheduleTabView *)tableView {
    
    if (!_tableView) {
        _tableView = [[DayScheduleTabView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.weekView.height - 64) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.layer.zPosition = -1;
        _tableView.backgroundColor = [UIColor colorWithHex:0x0A0A0A];
        _tableView.top = self.weekView.bottom;
        _tableView.dataArr = self.model.dayModels;
        
        __weak typeof(self) weakSelf = self;
        _tableView.selectBlock = ^(DayScheduleCell *cell, CGFloat contentOffY) {
            weakSelf.scheduleCell = cell;
            weakSelf.contentOffY = contentOffY;
            weakSelf.dynamicView.picArr = @[@"contactLogo1.jpg",
                                            @"contactLogo2.jpg",
                                            @"contactLogo3.jpg",
                                            @"contactPic.jpg"];
            [weakSelf.view addSubview:weakSelf.dynamicView];
            [weakSelf.dynamicView dynamicExpandAnimation];
        };
    }
    return _tableView;
}

- (DynamicView *)dynamicView {
    
    if (!_dynamicView) {
        _dynamicView = [[DynamicView alloc] initWithFrame:self.view.bounds];
        __weak typeof(self) weakSelf = self;
        _dynamicView.dismissBlock = ^() {

            [weakSelf.scheduleCell resetCellState];
        };
        _dynamicView.clickBlock = ^(UIButton *btn) {
            NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:weakSelf.scheduleCell];
            CGFloat y = (indexPath.row + 1) * weakSelf.scheduleCell.height + 184 - weakSelf.contentOffY - weakSelf.scheduleCell.height/2.0;
            [weakSelf.dynamicView clickViewAnimationWithBtn:btn andY:y scheduleCell:weakSelf.scheduleCell];
        };
    }
    return _dynamicView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
