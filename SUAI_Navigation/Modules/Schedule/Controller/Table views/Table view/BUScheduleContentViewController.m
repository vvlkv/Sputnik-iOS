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
#import "BUScheduleRefreshView.h"
#import "BUScheduleContentViewController+Delegate.h"
#import "BUScheduleContentViewController+DataSource.h"

@interface BUScheduleContentViewController () {
    BUAstronautView *austronautView;
    UITableView *scheduleTableView;
    BUScheduleRefreshView *customRefreshView;
    NSInteger viewType;
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation BUScheduleContentViewController


- (instancetype)initWithIndex:(NSUInteger)index
                      andType:(ScheduleType)type {
    self = [super init];
    if (self) {
        _type = type;
        _index = index;
        austronautView = (BUAstronautView *)[[NSBundle mainBundle] loadNibNamed:@"BUAstronautView"
                                                                          owner:self
                                                                        options:nil][0];
        CGRect tableViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 113);
        scheduleTableView = [[UITableView alloc] initWithFrame:tableViewFrame
                                                         style:UITableViewStyleGrouped];
        scheduleTableView.delegate = self;
        scheduleTableView.dataSource = self;
        [scheduleTableView setShowsHorizontalScrollIndicator:NO];
        [scheduleTableView setShowsVerticalScrollIndicator:NO];
        scheduleTableView.backgroundColor = [UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"BUScheduleTableViewCell" bundle:nil];
        [scheduleTableView registerNib:nib forCellReuseIdentifier:@"cellId"];
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.hidesWhenStopped = YES;
        [indicatorView startAnimating];
        [self.view addSubview:indicatorView];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    austronautView.frame = self.view.bounds;
    scheduleTableView.frame = self.view.bounds;
    indicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 10, self.view.frame.size.height/3 - 10, 20, 20);
}

//TODO
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    austronautView.frame = self.view.bounds;
    scheduleTableView.frame = self.view.bounds;
}

- (void)refresh {
    [indicatorView stopAnimating];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    if ([self.dataSource viewTypeAtIndex:_index andType:_type] == 0) {
        austronautView.frame = self.view.bounds;
        austronautView.message = [self.dataSource titleForViewAtIndex:_index andType:_type];
        [self.view addSubview:austronautView];
    } else if ([self.dataSource viewTypeAtIndex:_index andType:_type] == 1) {
        [self.view addSubview:scheduleTableView];
        [scheduleTableView reloadData];
        [self loadCustomRefresh];
    } else {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"Расписание не загружено :(";
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(20, 50, self.view.frame.size.width - 40, 200);
        [self.view addSubview:label];
    }
}

- (void)loadCustomRefresh {
    
    customRefreshView = [[NSBundle mainBundle] loadNibNamed:@"BUScheduleRefreshView"
                                                      owner:self
                                                    options:nil][0];
    
    customRefreshView.date = [self.dataSource dateForTableView:self];
    customRefreshView.week = [self.dataSource weekForTableView:self];
    customRefreshView.tintColor = [UIColor clearColor];
    customRefreshView.backgroundColor = [UIColor clearColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addSubview:customRefreshView];
    customRefreshView.frame = refreshControl.bounds;
    
    refreshControl.tintColor = [UIColor clearColor];
    refreshControl.backgroundColor = [UIColor clearColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 10) {
        scheduleTableView.refreshControl = refreshControl;
    } else {
        [scheduleTableView addSubview:refreshControl];
    }
}

- (void)refresh:(id)obj {
    [(UIRefreshControl *)obj endRefreshing];
}

@end
