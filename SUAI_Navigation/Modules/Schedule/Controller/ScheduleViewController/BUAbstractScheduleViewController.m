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
}

@end

@implementation BUAbstractScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    semesterView = [[BUSemesterView alloc] initWithFrame:self.view.frame];
    semesterView.delegate = [self.output delegate];
    semesterView.dataSource = [self.output dataSource];
    semesterView.segmentDelegate = self;
    [self.view addSubview:semesterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateWeekSegmentWithIndex:(NSUInteger)index {
    [semesterView updateWeekSegmentWithIndex:index];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [semesterView updateFrame:self.view.bounds];
}

- (void)updateView {
    [semesterView refresh];
}

- (void)obtainStartScheduleScreen:(NSUInteger)index {
    [semesterView moveToPage:index];
}

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.output didChangeWeekSegment:selectedScope];
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

- (void)animateSessionViewToRect:(CGRect)sessionRect andSemesterView:(CGRect)semesterRect {
    [UIView animateWithDuration:.3 animations:^{
        semesterView.frame = semesterRect;
    }];
}

@end
