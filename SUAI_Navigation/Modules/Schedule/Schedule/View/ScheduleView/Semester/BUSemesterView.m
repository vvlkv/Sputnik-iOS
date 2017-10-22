//
//  BUSemesterView.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSemesterView.h"
#import "BUCustomSegmentedControl.h"
#import "BUScheduleRefreshView.h"
#import "BUCapsPageView.h"
#import "BUScheduleContentDataSource.h"

@interface BUSemesterView () {
    BUScheduleRefreshView *dateView;
    BUCustomSegmentedControl *scheduleTypeControl;
    BUCapsPageView *capsPageView;
}

@end

@implementation BUSemesterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addDateView];
        [self addCapsPageView];
        [self addSegmentedControl];
    }
    return self;
}

- (void)addDateView {
    dateView = (BUScheduleRefreshView *)[[NSBundle mainBundle] loadNibNamed:@"BUScheduleRefreshView" owner:self options:nil][0];
    dateView.frame = CGRectMake(0, 0, self.frame.size.width, 56);
    [self addSubview:dateView];
}

- (void)addSegmentedControl {
    scheduleTypeControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Нижняя", @"Верхняя"]
                                                                  andType:BUSegmentTypeNormal];
    scheduleTypeControl.frame = CGRectMake(8, 64, self.frame.size.width - 16, 29);
    [self addSubview:scheduleTypeControl];
}

- (void)addCapsPageView {
    capsPageView = [[BUCapsPageView alloc] initWithFrame:self.frame];
    [self addSubview:capsPageView];
}

- (void)refresh {
    NSLog(@"refresh");
    [capsPageView refresh];
    [capsPageView updateDayIndicators];
}

- (void)refreshDate {
    if ([self.dataSource conformsToProtocol:@protocol(BUScheduleContentDataSource)]) {
        dateView.date = [self.dataSource currentDate];
    }
    if ([self.dataSource conformsToProtocol:@protocol(BUScheduleContentDataSource)]) {
        dateView.week = [self.dataSource currentWeek];
    }
}

- (void)moveToPage:(NSUInteger)pageIndex {
    [capsPageView moveToPage:pageIndex];
}

- (void)updateWeekSegmentWithIndex:(NSUInteger)index {
    scheduleTypeControl.selectedSegmentIndex = index;
}


#pragma mark - Setters

- (void)updateFrame:(CGRect)frame {
    capsPageView.frame = frame;
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    capsPageView.delegate = self.delegate;
}

- (void)setDataSource:(id)dataSource {
    _dataSource = dataSource;
    capsPageView.dataSource = self.dataSource;
}

- (void)setSegmentDelegate:(id)segmentDelegate {
    _segmentDelegate = segmentDelegate;
    scheduleTypeControl.delegate = self.segmentDelegate;
}

- (void)setCapsPageDataSource:(id)capsPageDataSource {
    _capsPageDataSource = capsPageDataSource;
    capsPageView.capsPageDataSource = self.capsPageDataSource;
}

@end
