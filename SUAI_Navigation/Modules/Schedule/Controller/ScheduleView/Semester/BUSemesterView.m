//
//  BUSemesterView.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSemesterView.h"
#import "BUCustomSegmentedControl.h"
#import "BUCapsPageView.h"

@interface BUSemesterView () {
    BUCustomSegmentedControl *scheduleTypeControl;
    BUCapsPageView *capsPageView;
}

@end

@implementation BUSemesterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCapsPageView];
        [self addSegmentedControl];
    }
    return self;
}

- (void)addSegmentedControl {
    scheduleTypeControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Четная", @"Нечетная"]
                                                                  andType:BUSegmentTypeNormal];
    scheduleTypeControl.frame = CGRectMake(8, 8, self.frame.size.width - 16, 29);
    [self addSubview:scheduleTypeControl];
}

- (void)addCapsPageView {
    capsPageView = [[BUCapsPageView alloc] initWithFrame:self.frame];
    [self addSubview:capsPageView];
}

- (void)refresh {
    [capsPageView refresh];
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

@end
