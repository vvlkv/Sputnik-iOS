//
//  BUNewsDetailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoViewController.h"
#import "BUNewsDetailInfoTableViewCell.h"
#import "BUNews.h"

@interface BUNewsDetailInfoViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *detailInfoNewsTableView;
    UIActivityIndicatorView *indicator;
}

@end

@implementation BUNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 49);
    detailInfoNewsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    detailInfoNewsTableView.delegate = self;
    detailInfoNewsTableView.dataSource = self;
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 10, CGRectGetHeight(self.view.frame)/2 - 10 - 64, 20, 20);
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    [self.output viewDidLoad];
    detailInfoNewsTableView.estimatedRowHeight = 101.f;
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
    BUNews *news = [self.dataSource newsModel];
    cell.date = news.date;
    cell.header = news.header;
    cell.image = news.image;
    cell.subHeader = news.subHeader;
    cell.text = news.text;
    return cell;
}


#pragma mark - BUNewsDetailInfoViewControllerInput

- (void)updateContent {
    [indicator stopAnimating];
    [self.view addSubview:detailInfoNewsTableView];
}

- (void)loadFailed {
    UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 100)];
    failLabel.text = @"Соединение с интернетом потеряно :(";
    failLabel.numberOfLines = 0;
    failLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:failLabel];
    [indicator stopAnimating];
}

@end
