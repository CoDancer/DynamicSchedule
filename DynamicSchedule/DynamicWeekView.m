//
//  DynamicWeekView.m
//  DynamicSchedule
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "DynamicWeekView.h"
#import "WeekViewCell.h"
#import "WeekModel.h"
#import "GlobalModel.h"

@interface DynamicWeekView()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger currentIdx;
@property (nonatomic, assign) BOOL swipeLeft;

@end

@implementation DynamicWeekView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[WeekViewCell class] forCellWithReuseIdentifier:@"WeekCell"];
        self.currentIdx = 2;
        self.dataSource = self;
        self.delegate = self;
        self.gestureRecognizers = nil;
        UISwipeGestureRecognizer *gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewSwipped:)];
        gestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer *gestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewSwipped:)];
        gestureRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:gestureLeft];
        [self addGestureRecognizer:gestureRight];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WeekViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeekCell" forIndexPath:indexPath];
    WeekModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(SCREEN_WIDTH/5.0, 120);
}

- (void)collectionViewSwipped:(UISwipeGestureRecognizer *)gesture {
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.swipeLeft = YES;
        ++self.currentIdx;
        
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        self.swipeLeft = NO;
        --self.currentIdx;
    }
    
    if (self.currentIdx >= [self.dataArr count] || self.currentIdx < 0) {
        if (self.currentIdx >= [self.dataArr count]) {
            self.currentIdx = [self.dataArr count] - 1;
        }else {
            self.currentIdx = 0;
        }
        return;
    }
    if (self.currentIdx < [self.dataArr count]) {
        [self scrollToViewCenter];
    }
}

- (void)scrollToViewCenter {
    
    WeekModel *model = self.dataArr[self.currentIdx];
    if (self.swipeBlock) {
        self.swipeBlock(model);
    }
    if (self.currentIdx > [self.dataArr count] - 3 || self.currentIdx < 2) {
        return;
    }else {
        float space = 0;
        float viewWidth = SCREEN_WIDTH/5.0;
        //滑动的时候判断
        if (self.contentSize.width - self.contentOffset.x - SCREEN_WIDTH/5.0 < SCREEN_WIDTH) {
            
            self.contentSize = CGSizeMake(self.contentSize.width + SCREEN_WIDTH/5.0 * 2,
                                          SCREEN_WIDTH/5.0 - 10);
        }
        [self scrollRectToVisible:CGRectMake((self.currentIdx - 2) * (viewWidth + space),
                                             0,
                                             self.frame.size.width,
                                             self.frame.size.height)
                         animated:YES];
    }
}

@end
