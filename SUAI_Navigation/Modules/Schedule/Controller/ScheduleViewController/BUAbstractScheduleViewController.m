//
//  BUAbstractScheduleViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 11.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractScheduleViewController.h"
#import "BUCustomSegmentedControl.h"
#import "BUSemesterView.h"

@interface BUAbstractScheduleViewController ()<BUCustomSegmentDelegate> {
    BUSemesterView *semesterView;
    BOOL updateAfterLoad;
    NSUInteger initialIndex;
}

@end

@implementation BUAbstractScheduleViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        updateAfterLoad = NO;
        initialIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    semesterView = [[BUSemesterView alloc] initWithFrame:self.view.frame];
    semesterView.delegate = [self.output delegate];
    semesterView.dataSource = [self.output dataSource];
    semesterView.segmentDelegate = self;
    semesterView.capsPageDataSource = [self.output dataSource];
    [self.view addSubview:semesterView];
    if (updateAfterLoad == YES) {
        [semesterView refresh];
        [semesterView refreshDate];
        [semesterView moveToPage:initialIndex];
    }
    UIImage *calendarImage = [UIImage imageNamed:@"Calendar.png"];
    UIBarButtonItem *calendarItem = [[UIBarButtonItem alloc] initWithImage:calendarImage style:UIBarButtonItemStylePlain target:self action:@selector(calendarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = calendarItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [semesterView updateFrame:self.view.bounds];
}

#pragma mark - BUScheduleViewControllerInput

- (void)obtainStartScheduleScreen:(NSUInteger)index {
    if (semesterView == nil) {
        initialIndex = index;
    } else {
        [semesterView moveToPage:index];
    }
}

- (void)updateView {
    if (semesterView == nil) {
        updateAfterLoad = YES;
    } else {
        [semesterView refresh];
    }
}

- (void)updateDate {
    [semesterView refreshDate];
}

- (void)updateWeekSegmentWithIndex:(NSUInteger)index {
    [semesterView updateWeekSegmentWithIndex:index];
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


#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.output didChangeWeekSegment:selectedScope];
}


#pragma mark - Other

- (void)calendarButtonPressed:(id)sender {
    [self.output didPressCalendarAction];
}

- (void)alertButtonPressed:(id)object {
    [self.output didPressAlertAction:object];
}

- (void)animateSessionViewToRect:(CGRect)sessionRect andSemesterView:(CGRect)semesterRect {
    [UIView animateWithDuration:.3 animations:^{
        semesterView.frame = semesterRect;
    }];
}

@end
