//
//  BUScheduleTableViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleTableViewController.h"

#import "BUAstronautView.h"
#import "BUScheduleTableViewCell.h"
#import "BUScheduleHeaderView.h"
#import "BUPairViewModel.h"

@interface BUScheduleTableViewController () {
    ScheduleType _type;
}

@end

static NSString *cellNibName = @"BUScheduleTableViewCell";
static NSString *headerNibName = @"BUScheduleHeaderView";
static NSString *backgroundViewName = @"BUAstronautView";

@implementation BUScheduleTableViewController

- (instancetype)initWithScheduleType:(ScheduleType)type index:(NSUInteger)index {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _type = type;
        _index = index;
    }
    return self;
}

- (instancetype)initWithIndex:(NSUInteger)index {
    return [self initWithScheduleType:ScheduleTypeSemester index:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    UINib *cellNib = [UINib nibWithNibName:cellNibName
                                bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellNibName];
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

- (void)p_addBackground:(UITableView *)tableView atIndex:(NSUInteger)index {
    BUAstronautView *austronautView = (BUAstronautView *)[[NSBundle mainBundle] loadNibNamed:backgroundViewName
                                                                                       owner:self
                                                                                     options:nil][0];
    austronautView.message = [self.dataSource tableView:self titleForAustronautAtIndex:index];
    austronautView.frame = self.view.bounds;
    tableView.backgroundView = austronautView;
    tableView.bounces = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource == nil)
        return 0;
    NSUInteger totalPairs = [self.dataSource tableView:self numberOfPairsAtIndex:_index];
    if (totalPairs == 0) {
        [self p_addBackground:tableView atIndex:_index];
    } else {
        tableView.bounces = YES;
        tableView.backgroundView = nil;
    }
    return totalPairs;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNibName];
    BUPairViewModel *viewModel = [self.dataSource tableView:self
                                           viewModelForPair:indexPath.section
                                                      atDay:_index];
    cell.name = [viewModel name];
    cell.teacherName = [viewModel subInfo];
    cell.teacherDegree = [viewModel teacherDegree];
    cell.pairType = [viewModel type];
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 37.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BUScheduleHeaderView *view = (BUScheduleHeaderView *)[[NSBundle mainBundle] loadNibNamed:headerNibName
                                                                                  owner:self
                                                                                options:nil][0];
    BUPairViewModel *viewModel = [self.dataSource tableView:self
                                           viewModelForPair:section atDay:_index];
    view.time = [viewModel time];
    view.auditory = [viewModel auditory];
    view.frame = CGRectMake(0, 0, tableView.frame.size.width, 37.f);
    view.backgroundColor = [self.dataSource headerColorForTableView:self];
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate tableView:self didSelectPair:indexPath.section atDay:_index];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (ScheduleType)type {
    return _type;
}

@end
