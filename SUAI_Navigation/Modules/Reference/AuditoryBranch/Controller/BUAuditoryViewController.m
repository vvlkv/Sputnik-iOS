//
//  BUAuditoryViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 26.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAuditoryViewController.h"
#import "BUAuditoryInfoViewController.h"
#import "BUTableView.h"
#import "BUAuditoriesModel.h"
#import "BUCustomSegmentedControl.h"

@interface BUAuditoryViewController ()<BUTableViewDataSource, BUTableViewDelegate, BUAuditoryInfoViewControllerDelegate, BUCustomSegmentDelegate> {
    BUTableView *tableView;
    BUAuditoriesModel *model;
    BUCustomSegmentedControl *segmentedControl;
    NSUInteger barState;
}

@end

@implementation BUAuditoryViewController


#pragma mark - Root

- (void)viewDidLoad {
    [super viewDidLoad];
    barState = 0;
    model = [[BUAuditoriesModel alloc] init];
    [model prepareInformationData];
    tableView = [[NSBundle mainBundle] loadNibNamed:@"BUTableView"
                                                     owner:self
                                                   options:nil][0];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 45, self.view.frame.size.width, CGRectGetHeight(self.view.frame) - 45);
    self.title = @"Справочник";
    [self.view addSubview:tableView];
    
    segmentedControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Аудитории", @"Институты", @"Отделы"] andType:BUSegmentTypeNormal];
    segmentedControl.delegate = self;
    segmentedControl.frame = CGRectMake(8, 8, self.view.frame.size.width - 16, 29);
    [self.view addSubview:segmentedControl];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark - BUTableViewDataSource

- (NSUInteger)numberOfRowsInTableView:(BUTableView *)tableView forSection:(NSUInteger)section {
    return [model itemsCountForSection:section];
}

- (NSString *)tableView:(BUTableView *)tableView titleAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    return [model titleAtIndex:index inSection:section];
}
- (NSString *)tableView:(BUTableView *)tableView headerAtIndex:(NSUInteger)index {
    return [model headerAtIndex:index];
}

- (NSUInteger)numberOfSectionsInTableView:(BUTableView *)tableView {
    return [model sectionsCountAtIndex:segmentedControl.selectedSegmentIndex];
}

- (BOOL)tableView:(BUTableView *)tableView isSelectableCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    return [model isSelectableAtIndex:index inSection:section];
}


#pragma mark - BUTableViewDelegate

- (void)tableView:(BUTableView *)tableView didChangedSearchText:(NSString *)searchText {
    if ([searchText length] == 4) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate viewController:self foundAuditory:searchText];
    }
}

- (void)tableView:(BUTableView *)tableView didSelectedCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    if ([model isSelectableAtIndex:index inSection:section]) {
        id targetModel = [model entityAtIndex:index inSection:section];
        [self loadAuditoryInfoViewControllerWithData:targetModel];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate viewController:self foundAuditory:[model auditoryAtIndex:index inSection:section]];
    }
}

- (void)didChangedStateInTableView:(BUTableView *)tableView {
    barState ^= 1;
    [self.navigationController setNavigationBarHidden:barState animated:YES];
}

#pragma mark - Actions

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BUAuditoryInfoViewController *controller = (BUAuditoryInfoViewController *)((UINavigationController *)[segue destinationViewController]);
    controller.data = sender;
    controller.delegate = self;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)loadAuditoryInfoViewControllerWithData:(id)data {
    BUAuditoryInfoViewController *controller = [[BUAuditoryInfoViewController alloc] init];
    controller.data = data;
    controller.delegate = self;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [model updateScope:selectedScope];
    [self updateBackButtonTitle];
    [tableView reloadData];
}

#pragma mark - Setters

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.navigationController.navigationBar.topItem.title = _titleText;
}

- (void)viewController:(BUAuditoryInfoViewController *)viewController didDismissedWithAuditory:(NSString *)auditory {
    [self.delegate viewController:self foundAuditory:auditory];
}

- (void)updateBackButtonTitle {
    NSArray *scopes = @[@"Аудитории", @"Институты", @"Отделы"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:scopes[[model selectedScope]]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil action:nil];
}

@end
