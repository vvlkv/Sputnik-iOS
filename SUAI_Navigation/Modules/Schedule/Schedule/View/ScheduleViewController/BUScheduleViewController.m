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
#import "BUScheduleRefreshView.h"
#import "BUGuestView.h"
#import "BUScheduleContentViewController.h"

@interface BUScheduleViewController () <BUCustomSegmentDelegate, BUGuestViewDelegate> {
    BUGuestView *guestView;
    BUCustomSegmentedControl *scheduleSegment;
    BUScheduleRefreshView *dateView;
    BUCustomSegmentedControl *scheduleTypeControl;
    UIView *scheduleWeekView;
    BUScheduleContentViewController *sessionView;
}

@end

@implementation BUScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScheduleTypeControl];
    [self addWeekTypeControl];
    [self addDateView];
    [self addSessionView];
    [self.output viewDidLoad];
}

- (void)addScheduleTypeControl {
    scheduleSegment = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Семестр", @"Сессия"]
                                                              andType:BUSegmentTypeWhite];
    scheduleSegment.delegate = self;
    self.navigationItem.titleView = scheduleSegment;
}

- (void)addWeekTypeControl {
    CGFloat yPos = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - 45;
    scheduleWeekView = [[UIView alloc] initWithFrame:CGRectMake(0, yPos, self.view.frame.size.width, 45)];
    scheduleWeekView.backgroundColor = [UIColor whiteColor];
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, scheduleWeekView.frame.size.width, .5f);
    topBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [scheduleWeekView.layer addSublayer:topBorder];
    scheduleTypeControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Нижняя", @"Верхняя"]
                                                                  andType:BUSegmentTypeNormal];
    scheduleTypeControl.frame = CGRectMake(8, 8, self.view.frame.size.width - 16, 29);
    [scheduleWeekView addSubview:scheduleTypeControl];
    [self.navigationController.view addSubview:scheduleWeekView];
}

- (void)addDateView {
    CGFloat yPos = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    dateView = (BUScheduleRefreshView *)[[NSBundle mainBundle] loadNibNamed:@"BUScheduleRefreshView" owner:self options:nil][0];
    dateView.frame = CGRectMake(0, yPos, self.view.frame.size.width, 56);
    dateView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:dateView];
}

- (void)addSessionView {
    sessionView = [[BUScheduleContentViewController alloc] initWithIndex:0 andType:ScheduleTypeSession];
    sessionView.delegate = [self.output delegate];
    sessionView.dataSource = [self.output dataSource];
    CGFloat yPos = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height + 56;
    sessionView.view.frame = CGRectMake(self.view.frame.size.width, yPos, self.view.frame.size.width, self.view.frame.size.height - yPos);
    [self.view addSubview:sessionView.view];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    scheduleTypeControl.delegate = self;
    if (scheduleSegment.selectedSegmentIndex == 1) {
        [self showTabBarUpperLine:YES];
    }
}

- (void)loadScheduleView {
    if (guestView != nil)
        [guestView removeFromSuperview];
    [super loadScheduleView];
    [sessionView refresh];
}

- (void)loadFailView {
    guestView = (BUGuestView *)[[NSBundle mainBundle] loadNibNamed:@"BUGuestView"
                                                                          owner:self
                                                                        options:nil][0];
    guestView.delegate = self;
    guestView.frame = self.view.frame;
    [self.view addSubview:guestView];
}

- (void)updateDate:(NSString *)date andWeek:(NSString *)week {
    dateView.date = date;
    dateView.week = week;
}

- (void)showSearchIcon {
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                  target:self
                                                                                  action:@selector(searchView:)];
    self.navigationItem.leftBarButtonItem = searchButton;
}

- (void)hideSearchIcon {
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)showNewScheduleAlert {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Появилось новое расписание!" message:@"Ваше расписание обновлено" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alertViewController addAction:okAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showTabBarUpperLine:(BOOL)isShown {
    UITabBar *tabBar = [[self tabBarController] tabBar];
    tabBar.clipsToBounds = !isShown;
}

#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if ([customSegment isEqual:scheduleSegment]) {
        if (selectedScope == 0) {
            [self showTabBarUpperLine:NO];
        } else {
            [self showTabBarUpperLine:YES];
        }
        [self.output didChangeScheduleSegment:selectedScope];
        [self animateViewForIndex:selectedScope];
        CGRect segmentRect = scheduleWeekView.frame;
        segmentRect.origin.y = (selectedScope == 0) ? scheduleWeekView.frame.origin.y - 45 : scheduleWeekView.frame.origin.y + 45;
        [self animateWeekSegmentToRect:segmentRect];
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
        self->sessionView.view.frame = sessionRect;
    }];
}

- (void)animateViewForIndex:(NSUInteger)index {
    [super animateViewForIndex:index];
    CGRect sessionRect = sessionView.view.frame;
    sessionRect.origin.x = (index == 1) ? 0 : self.view.frame.size.width;
    [UIView animateWithDuration:.3 animations:^{
        self->sessionView.view.frame = sessionRect;
    }];
}

- (void)animateWeekSegmentToRect:(CGRect)rect {
    [UIView animateWithDuration:.3 animations:^{
        self->scheduleWeekView.frame = rect;
    }];
}

- (void)didPressJumpToSettingsButtonInGuestView:(BUGuestView *)guestView {
    [self.output didPressGoToSettingsButton];
}

@end
