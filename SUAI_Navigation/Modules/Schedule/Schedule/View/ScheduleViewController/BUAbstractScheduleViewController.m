//
//  BUAbstractScheduleViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 11.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractScheduleViewController.h"
#import "BUCustomSegmentedControl.h"
#import "BUScheduleRefreshView.h"
#import "BUCapsPageView.h"

@interface BUAbstractScheduleViewController () {
    CGFloat capsPageHeight;
}

@property (weak, nonatomic) IBOutlet BUCapsPageView *capsPageView;

@end

@implementation BUAbstractScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCapsPageView];
    [self addCalendarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showTabBarUpperLine:NO];
    if (self.capsPageView != nil) {
        [self.output didChangeWeekSegment:self.weekTypeSegmentedControl.selectedSegmentIndex];
    }
    [_capsPageView layoutSubviews];
}


- (void)addCapsPageView {
    self.capsPageView.delegate = [self.output delegate];
    self.capsPageView.dataSource = [self.output dataSource];
    self.capsPageView.capsPageDataSource = [self.output dataSource];
}

- (void)addCalendarItem {
    UIImage *calendarImage = [UIImage imageNamed:@"Calendar.png"];
    UIBarButtonItem *calendarItem = [[UIBarButtonItem alloc] initWithImage:calendarImage style:UIBarButtonItemStylePlain target:self action:@selector(calendarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = calendarItem;
}


#pragma mark - BUScheduleViewControllerInput

- (void)obtainStartScheduleScreen:(NSUInteger)index {
    [self.capsPageView moveToPage:index];
}

- (void)loadScheduleView {
    [self.capsPageView refresh];
}

- (void)update {
    [self.capsPageView refresh];
}

- (void)updateWeekSegmentWithIndex:(NSUInteger)index {
    self.weekTypeSegmentedControl.selectedSegmentIndex = index;
}

- (void)showTabBarUpperLine:(BOOL)isShown {
    UITabBar *tabBar = [[self tabBarController] tabBar];
    tabBar.clipsToBounds = !isShown;
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

- (BUCustomSegmentedControl *)weekTypeSegmentedControl {
    for (UIView *view in [self.navigationController.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            for (UIView *subView in [view subviews]) {
                if ([subView isKindOfClass:[BUCustomSegmentedControl class]]) {
                    if ([((BUCustomSegmentedControl *)subView) type] == BUSegmentTypeNormal)
                        return (BUCustomSegmentedControl *)subView;
                }
            }
        }
    }
    return nil;
}

#pragma mark - Other

- (void)calendarButtonPressed:(id)sender {
    [self.output didPressCalendarAction];
}

- (void)alertButtonPressed:(id)object {
    [self.output didPressAlertAction:object];
}

- (void)animateViewForIndex:(NSUInteger)index {
    CGRect capsPageRect = self.capsPageView.frame;
    capsPageRect.origin.x = (index == 0) ? 0 : -self.view.frame.size.width;
    [UIView animateWithDuration:.3 animations:^{
        self.capsPageView.frame = capsPageRect;
    }];
}

- (void)animateSessionViewToRect:(CGRect)sessionRect andSemesterView:(CGRect)semesterRect {
    [UIView animateWithDuration:.3 animations:^{
        self.capsPageView.frame = semesterRect;
    }];
}
@end
