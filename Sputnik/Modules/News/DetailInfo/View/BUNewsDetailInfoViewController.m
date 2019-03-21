//
//  BUNewsDetailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoViewController.h"
#import "BUNewsDetailInfoTableViewCell.h"
#import "SUAINews.h"
#import "UIViewController+Anchor.h"

@interface BUNewsDetailInfoViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *detailInfoNewsTableView;
}

@end

@implementation BUNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    detailInfoNewsTableView = [[UITableView alloc] init];
    detailInfoNewsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    detailInfoNewsTableView.delegate = self;
    detailInfoNewsTableView.dataSource = self;
    [self.output viewDidLoad];
    [self showActivityIndicator];
    detailInfoNewsTableView.estimatedRowHeight = 101.f;
    detailInfoNewsTableView.hidden = YES;
    [self.view addSubview:detailInfoNewsTableView];
    [[detailInfoNewsTableView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[detailInfoNewsTableView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    [[detailInfoNewsTableView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[detailInfoNewsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    BUNewsDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = (BUNewsDetailInfoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"BUNewsDetailInfoTableViewCell"
                                                                              owner:self
                                                                            options:nil][0];
    }
    SUAINews *news = [self.dataSource newsModel];
    cell.date = news.date;
    cell.header = news.header;
    cell.image = news.image;
    cell.subHeader = news.subHeader;
    cell.text = news.text;
    return cell;
}


#pragma mark - BUNewsDetailInfoViewControllerInput

- (void)updateContent {
    [self hideActivityIndicator];
    [self hideInternetFailView];
    detailInfoNewsTableView.hidden = NO;
    [detailInfoNewsTableView reloadData];
}

- (void)loadFailed {
    [self hideActivityIndicator];
    [self showInternetFailView];
}

@end
