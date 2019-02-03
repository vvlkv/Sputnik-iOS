//
//  BUCalendarNewViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUCalendarViewController.h"
#import "BUCalendar.h"
#import "BUWeekDescriptionView.h"

#import "UIColor+SUAI.h"
#import "UIFont+SUAI.h"

#import "BUDateFormatter.h"
#import "NSCalendar+CurrentDay.h"

#import "BUScheduleTableViewController.h"

#import "UIViewController+Anchor.h"

#import "BUCalendarViewControllerOutput.h"

@interface BUCalendarViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource, UIGestureRecognizerDelegate, BUCalendarViewControllerInput> {
    BUCalendar *calendar;
    BUWeekDescriptionView *weekView;
    BUScheduleTableViewController *scheduleTableView;
    NSLayoutConstraint *calendarHeightConstraint;
}

@end

CGFloat const weekDescriptionHeight = 44.f;

@implementation BUCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self action:@selector(dismiss)];
    self.title = @"Календарь";
    [self p_configureCalendar];
    [self p_configureWeekDescriptionView];
    [self p_configureTableView];
    [self p_configureGesture];
    [self.output viewDidLoad];
}

- (void)p_configureCalendar {
    calendar = [[BUCalendar alloc] init];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:calendar];
    [[calendar.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[calendar.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[calendar.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    calendarHeightConstraint = [calendar.heightAnchor constraintEqualToConstant:self.view.frame.size.height/2 - weekDescriptionHeight * 2];
    [calendarHeightConstraint setActive:YES];
}

- (void)p_configureWeekDescriptionView {
    weekView = [[BUWeekDescriptionView alloc] init];
    weekView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:weekView];
    [[NSLayoutConstraint constraintWithItem:weekView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:calendar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0] setActive:YES];
    [[weekView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[weekView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    [[weekView.heightAnchor constraintEqualToConstant:weekDescriptionHeight] setActive:YES];
    weekView.weekDescription = [BUDateFormatter dateFromData:[NSDate date]];
}

- (void)p_configureTableView {
    scheduleTableView = [[BUScheduleTableViewController alloc] initWithScheduleType:ScheduleTypeSemester index:0];
    scheduleTableView.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scheduleTableView.view];
    [[scheduleTableView.view.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[scheduleTableView.view.widthAnchor constraintEqualToConstant:self.view.frame.size.width] setActive:YES];
    [[scheduleTableView.view.topAnchor constraintEqualToAnchor:weekView.bottomAnchor] setActive:YES];
    [[scheduleTableView.view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
}

- (void)p_configureGesture {
    UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc] initWithTarget:calendar action:@selector(handleScopeGesture:)];
    swipe.delegate = self;
    [self.view addGestureRecognizer:swipe];
}

#pragma mark - FSCalendarDelegateAppearance

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    NSCalendar *calendarw = [NSCalendar currentCalendar];
    NSUInteger dayIndex = [NSCalendar weekIndexFromDate:date];
    UIColor *color = (dayIndex % 2 == 1) ? [UIColor suaiRedColor] : [UIColor suaiBlueColor];
    NSUInteger selectedMonthsNumber = [calendarw component:NSCalendarUnitMonth fromDate:calendar.currentPage];
    NSUInteger currentMonthsNumber = [calendarw component:NSCalendarUnitMonth fromDate:date];
    NSDateComponents *components = [calendarw components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if ([[calendarw dateFromComponents:components] isEqualToDate:date]) {
        return [UIColor whiteColor];
    }
    if (selectedMonthsNumber != currentMonthsNumber) {
        return [UIColor grayColor];
    } else {
        return color;
    }
    return color;
}


#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    UIColor *color;
    if (monthPosition == FSCalendarMonthPositionCurrent) {
        NSUInteger dayIndex = [NSCalendar weekIndexFromDate:date];
        color = (dayIndex % 2 == 1) ? [UIColor suaiRedColor] : [UIColor suaiBlueColor];
    } else {
        color = [UIColor grayColor];
    }
    cell.titleLabel.textColor = cell.dateIsToday || cell.isSelected ? [UIColor whiteColor] : color;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSCalendar *cal = [NSCalendar currentCalendar];
    if (monthPosition == FSCalendarMonthPositionNext)
        [calendar setCurrentPage:[cal dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:calendar.currentPage options:0] animated:YES];
    if (monthPosition == FSCalendarMonthPositionPrevious)
        [calendar setCurrentPage:[cal dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:calendar.currentPage options:0] animated:YES];
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    scheduleTableView.index = [NSCalendar dayFromDate:date];
    [self.output didSelectDate:date];
    weekView.weekDescription = [BUDateFormatter dateFromData:date];
}


#pragma mark - BUCalendarNewViewControllerInput

- (void)updateSchedule {
    [scheduleTableView reloadTableView];
}

- (void)showAlertControllerWithItems:(NSArray<NSString *> *)items selected:(void (^) (NSInteger index))selectionBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *item in items) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (selectionBlock != nil)
                selectionBlock([items indexOfObject:item]);
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dataSource:(id<BUScheduleTableViewControllerDataSource>)dataSource {
    scheduleTableView.dataSource = dataSource;
    [scheduleTableView reloadTableView];
}

- (void)delegate:(id<BUScheduleTableViewControllerDelegate>)delegate {
    scheduleTableView.delegate = delegate;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
