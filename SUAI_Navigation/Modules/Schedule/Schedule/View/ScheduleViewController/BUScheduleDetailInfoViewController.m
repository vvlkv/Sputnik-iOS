//
//  BUScheduleDatailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleDetailInfoViewController.h"
#import "BUCustomSegmentedControl.h"
#import "SVPRogressHUD.h"

@interface BUScheduleDetailInfoViewController () <BUCustomSegmentDelegate>

@end

@implementation BUScheduleDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewDidLoadWithWeekSegmentIndex:[[self weekTypeSegmentedControl] selectedSegmentIndex]];
    [SVProgressHUD show];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.weekTypeSegmentedControl.delegate = self;
}

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.output didChangeWeekSegment:selectedScope];
}

- (void)loadScheduleView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    [super loadScheduleView];
}

@end
