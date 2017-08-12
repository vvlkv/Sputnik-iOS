//
//  BUScheduleViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 11.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleViewController.h"
#import "BUCustomSegmentedControl.h"
#import "BUScheduleSearchViewController.h"
#import "BUSessionView.h"

@interface BUScheduleViewController () <BUCustomSegmentDelegate> {
    BUCustomSegmentedControl *scheduleSegment;
    BUSessionView *sessionView;
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation BUScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scheduleSegment = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Семестр", @"Сессия"]
                                                              andType:BUSegmentTypeWhite];
    scheduleSegment.delegate = self;
    self.navigationItem.titleView = scheduleSegment;
    
    sessionView = [[BUSessionView alloc] initWithFrame:self.view.frame];
    sessionView.delegate = [self.output delegate];
    sessionView.dataSource = [self.output dataSource];
    [self.view addSubview:sessionView];
    [self.output viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sessionView updateFrame:self.view.bounds];
    CGRect sessionFrame = self.view.bounds;
    if (scheduleSegment.selectedSegmentIndex == 0) {
        sessionFrame.origin.x = self.view.bounds.size.width;
    }
    sessionView.frame = sessionFrame;
}

- (void)updateView {
    [super updateView];
    [sessionView refresh];
}

- (void)showSearchIcon {
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchView:)];
    self.navigationItem.leftBarButtonItem = searchButton;
}


#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if ([customSegment isEqual:scheduleSegment]) {
        [self.output didChangeScheduleSegment:selectedScope];
        CGRect sessionRect = sessionView.frame;
        CGRect semesterRect = self.view.bounds;
        semesterRect.origin.x = (selectedScope == 0) ? 0 : -self.view.frame.size.width;
        sessionRect.origin.x = (selectedScope == 0) ? self.view.frame.size.width : 0;
        [self animateSessionViewToRect:sessionRect andSemesterView:semesterRect];
    } else {
        [self.output didChangeWeekSegment:selectedScope];
    }
}

- (void)searchView:(id)target {
    [self.output didPressSearchButton];
}

- (void)animateSessionViewToRect:(CGRect)sessionRect andSemesterView:(CGRect)semesterRect {
    [super animateSessionViewToRect:sessionRect andSemesterView:semesterRect];
    [UIView animateWithDuration:.3 animations:^{
        sessionView.frame = sessionRect;
    }];
}

@end
