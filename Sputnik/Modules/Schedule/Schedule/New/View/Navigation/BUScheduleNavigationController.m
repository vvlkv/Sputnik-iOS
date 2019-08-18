//
//  BUScheduleNavigationController.m
//  SUAI_Navigation
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleNavigationController.h"
#import "BUScheduleRefreshView.h"
#import "BUCustomSegmentedControl.h"
#import "UIViewController+Anchor.h"
#import "TitleSegmentedControlView.h"

@interface BUScheduleNavigationController ()

@property (strong, nonatomic) NSLayoutConstraint *bottom;
@property (strong, nonatomic) BUCustomSegmentedControl *scheduleTypeControl;
@property (strong, nonatomic) BUScheduleRefreshView *dateView;

@end

CGFloat const bottomConstant = 49;
NSString *const refreshViewName = @"BUScheduleRefreshView";

@implementation BUScheduleNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_addDateView];
    [self p_addWeekTypeControl];
    _controlVisible = YES;
}

- (void)p_addDateView {
    _dateView = (BUScheduleRefreshView *)[[NSBundle mainBundle] loadNibNamed:refreshViewName
                                                                       owner:self
                                                                     options:nil][0];
    _dateView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_dateView];
    NSLayoutConstraint *top = [_dateView.topAnchor constraintEqualToAnchor:self.topAnchor constant:44.f];
    NSLayoutConstraint *left = [_dateView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    NSLayoutConstraint *right = [_dateView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
    NSLayoutConstraint *height = [_dateView.heightAnchor constraintEqualToConstant:56.f];
    [self.view addConstraints:@[right, height, top, left]];
}

- (void)p_addWeekTypeControl {
    UIView *scheduleWeekView = [[UIView alloc] init];
    scheduleWeekView.translatesAutoresizingMaskIntoConstraints = NO;
    _scheduleTypeControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Нижняя", @"Верхняя"]
                                                                  andType:BUSegmentTypeNormal];
    _scheduleTypeControl.frame = CGRectMake(8, 8, self.view.frame.size.width - 16, 29);
    [_scheduleTypeControl addTarget:self action:@selector(p_controlChanged:) forControlEvents:UIControlEventValueChanged];
    [scheduleWeekView addSubview:_scheduleTypeControl];
    [self.view addSubview:scheduleWeekView];
    
    _bottom = [scheduleWeekView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-bottomConstant];
    NSLayoutConstraint *left = [scheduleWeekView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    NSLayoutConstraint *right = [scheduleWeekView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
    NSLayoutConstraint *height = [scheduleWeekView.heightAnchor constraintEqualToConstant:45.f];
    [self.view addConstraints:@[right, height, _bottom, left]];
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, .5f);
    topBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [scheduleWeekView.layer addSublayer:topBorder];
}

- (void)p_controlChanged:(UISegmentedControl *)control {
    NSUInteger selectedIndex = [control selectedSegmentIndex];
    [self.controlDelegate navigationController:self didChangeWeekTypeControl:selectedIndex];
}

- (void)setDate:(NSString *)date andWeek:(NSString *)week {
    _dateView.date = date;
    _dateView.week = week;
}

- (void)setControlVisible:(BOOL)controlVisible {
    if (self.controlVisible == controlVisible) {
        if (controlVisible) {
            UITabBar *tab = [[self tabBarController] tabBar];
            tab.clipsToBounds = controlVisible == YES;
        }
        return;
    }
    _controlVisible = controlVisible;
    __weak typeof(self) welf = self;
    _bottom.constant = controlVisible == YES ? bottomConstant * -1 : 0;
    [UIView animateWithDuration:.3 animations:^{
        [welf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        UITabBar *tab = [[welf tabBarController] tabBar];
        tab.clipsToBounds = controlVisible == YES;
    }];
}

- (NSUInteger)weekIndex {
    return [_scheduleTypeControl selectedSegmentIndex];
}

- (void)setWeekIndex:(NSUInteger)weekIndex {
    _scheduleTypeControl.selectedSegmentIndex = weekIndex;
}

@end
