//
//  BUCalendarViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCalendarViewController.h"
#import "BUWeekDescriptionView.h"
#import "BUDateFormatter.h"
#import "BUAstronautView.h"
#import "BUScheduleContentViewController.h"
#import "UIColor+SUAI.h"
#import "UIFont+SUAI.h"
#import "NSCalendar+CurrentDay.h"
#import <FSCalendar.h>

@interface BUCalendarViewController () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource, UIGestureRecognizerDelegate,  UIScrollViewDelegate> {
    BUScheduleContentViewController *scheduleTableView;
    FSCalendar *calendar;
    BUWeekDescriptionView *weekView;
}

@end

@implementation BUCalendarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.title = @"Календарь";
    calendar = [self assemblyCalendar];
    weekView = [self assemblyWeekView];
    scheduleTableView = [self assemblySchedule];
    UIPanGestureRecognizer *swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:calendar action:@selector(handleScopeGesture:)];
    swipeGesture.delegate = self;
    UIPanGestureRecognizer *swipeGesture2 = [[UIPanGestureRecognizer alloc] initWithTarget:calendar action:@selector(handleScopeGesture:)];
    swipeGesture2.delegate = self;
    [scheduleTableView.view addGestureRecognizer:swipeGesture];
    [weekView addGestureRecognizer:swipeGesture2];
    [self.output viewDidLoad];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (FSCalendar *)assemblyCalendar {
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2 - 44)];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru-RU"];
    calendar.firstWeekday = 2;
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.scope = FSCalendarScopeMonth;
    UIPanGestureRecognizer *scopeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:calendar action:@selector(handleScopeGesture:)];
    scopeGesture.delegate = self;
    calendar.appearance.titleFont = [UIFont suaiRobotoFont:RobotoFontMedium size:17.f];
    calendar.appearance.weekdayFont = [UIFont suaiRobotoFont:RobotoFontMedium size:14.f];
    calendar.appearance.weekdayTextColor = [UIColor blackColor];
    calendar.appearance.headerTitleFont = [UIFont suaiRobotoFont:RobotoFontBold size:18.f];
    calendar.appearance.headerTitleColor = [UIColor blackColor];
    calendar.appearance.selectionColor = [UIColor suaiPurpleColor];
    calendar.appearance.titleTodayColor = [UIColor whiteColor];
    calendar.appearance.todayColor = [UIColor suaiLightPurpleColor];
    [calendar addGestureRecognizer:scopeGesture];
    [self.view addSubview:calendar];
    return calendar;
}

- (BUWeekDescriptionView *)assemblyWeekView {
    BUWeekDescriptionView *textView = [[BUWeekDescriptionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 44, self.view.frame.size.width, 44)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.weekDescription = [BUDateFormatter dateFromData:[NSDate date]];
    [self.view addSubview:textView];
    return textView;
}

- (BUScheduleContentViewController *)assemblySchedule {
    BUScheduleContentViewController *scheduleTableView = [[BUScheduleContentViewController alloc] initWithIndex:0
                                                                                                        andType:ScheduleTypeSemester];
    CGRect scheduleFrame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    scheduleTableView.view.frame = scheduleFrame;
    scheduleTableView.dataSource = [self.output dataSource];
    scheduleTableView.delegate = [self.output delegate];
    [self.view addSubview:scheduleTableView.view];
    return scheduleTableView;
}



#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    weekView.frame = (CGRect){0, bounds.size.height, weekView.frame.size};
    CGRect scheduleFrame = (CGRect){0, bounds.size.height + 44, self.view.frame.size.width, self.view.frame.size.height - bounds.size.height - 44};
    scheduleTableView.view.frame = scheduleFrame;
}

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

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date 
 atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self.output didSelectDate:date];
    weekView.weekDescription = [BUDateFormatter dateFromData:date];
}

- (void)reloadView {
    [scheduleTableView refresh];
}

- (void)setDayIndex:(NSUInteger)index {
    scheduleTableView.index = index;
}

- (void)addAlertViewWithItems:(NSArray *)items {
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:nil
                               message:nil
                               preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *title in items) {
        UIAlertAction *item = [UIAlertAction
                               actionWithTitle:title
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   [self performSelector:@selector(alertButtonPressed:) withObject:title];
                                   [view dismissViewControllerAnimated:YES completion:nil];
                               }];
        [view addAction:item];
    }
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)alertButtonPressed:(id)object {
    [self.output didPressAlertAction:object];
}

- (void)didPressGoToSettingsButton {
    [self.output didPressGoToSettingsButton];
}

@end
