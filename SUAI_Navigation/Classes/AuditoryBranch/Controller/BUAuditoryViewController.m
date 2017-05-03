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

@interface BUAuditoryViewController ()<BUTableViewDataSource, BUTableViewDelegate> {
    BUTableView *tableView;
    BUAuditoriesModel *model;
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
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(self.view.frame) - 44);
    [self.view addSubview:tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (NSUInteger)numberOfSectionsInTableView:(BUTableView *)tableView atIndex:(NSUInteger)index {
    return [model sectionsCountAtIndex:index];
}

- (BOOL)tableView:(BUTableView *)tableView isSelectableCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    return [model isSelectableAtIndex:index inSection:section];
}


#pragma mark - BUTableViewDelegate

- (void)tableView:(BUTableView *)tableView didChangedSearchText:(NSString *)searchText {
    //TODO
}

- (void)tableView:(BUTableView *)tableView didChangedScopeIndex:(NSUInteger)index {
    [model updateScope:index];
}

- (void)tableView:(BUTableView *)tableView didSelectedCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    if ([model isSelectableAtIndex:index inSection:section]) {
        id targetModel = [model entityAtIndex:index inSection:section];
        [self performSegueWithIdentifier:@"showDetail" sender:targetModel];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didChangedStateInTableView:(BUTableView *)tableView {
    barState ^= 1;
    [self.navigationController setNavigationBarHidden:barState animated:YES];
}


#pragma mark - Actions

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate viewController:self foundAuditory:@"1229"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BUAuditoryInfoViewController *controller = (BUAuditoryInfoViewController *)((UINavigationController *)[segue destinationViewController]);
    controller.data = sender;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
}


#pragma mark - Setters

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.navigationController.navigationBar.topItem.title = _titleText;
}

@end
