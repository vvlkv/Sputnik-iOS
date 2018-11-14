//
//  BUScheduleContentViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleContentViewController.h"
#import "BUScheduleTableViewCell.h"
#import "BUScheduleHeaderView.h"
#import "BUAstronautView.h"
#import "BUGuestView.h"
#import "BUScheduleRefreshView.h"
#import "BUScheduleContentViewController+Delegate.h"
#import "BUScheduleContentViewController+DataSource.h"

@interface BUScheduleContentViewController () {
    BUAstronautView *austronautView;
    UITableView *scheduleTableView;
}

@end

@implementation BUScheduleContentViewController

- (instancetype)initWithIndex:(NSUInteger)index
                      andType:(ScheduleType)type {
    self = [super init];
    if (self) {
        _type = type;
        _index = index;
    }
    return self;
}

- (void)refresh {
    [self.dataSource typeOfViewForViewController:self];
}

- (void)showSchedule {
    if (scheduleTableView == nil) {
        scheduleTableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                         style:UITableViewStyleGrouped];
        scheduleTableView.delegate = self;
        scheduleTableView.dataSource = self;
        [scheduleTableView setShowsHorizontalScrollIndicator:NO];
        [scheduleTableView setShowsVerticalScrollIndicator:NO];
        scheduleTableView.backgroundColor = [UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"BUScheduleTableViewCell"
                                    bundle:nil];
        [scheduleTableView registerNib:nib forCellReuseIdentifier:@"cellId"];
    } else {
        [scheduleTableView reloadData];
    }
    self.view = scheduleTableView;
}

- (void)showAustronaut {
    if (austronautView == nil) {
        austronautView = (BUAstronautView *)[[NSBundle mainBundle] loadNibNamed:@"BUAstronautView"
                                                                          owner:self
                                                                        options:nil][0];
        austronautView.message = [self.dataSource titleForViewAtIndex:_index andType:_type];
        austronautView.frame = self.view.frame;
    }
    self.view = austronautView;
}

@end
