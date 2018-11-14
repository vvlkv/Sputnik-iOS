//
//  BUNewsDetailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoViewController.h"
#import "SVProgressHUD.h"
#import "BUNewsDetailInfoTableViewCell.h"
#import "BUNews.h"

@interface BUNewsDetailInfoViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *detailInfoNewsTableView;
}

@end

@implementation BUNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    detailInfoNewsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    detailInfoNewsTableView.delegate = self;
    detailInfoNewsTableView.dataSource = self;
    [self.output viewDidLoad];
    [SVProgressHUD show];
    detailInfoNewsTableView.estimatedRowHeight = 101.f;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    detailInfoNewsTableView.frame = self.view.bounds;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    [self.view addSubview:detailInfoNewsTableView];
}

- (void)loadFailed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 100)];
    failLabel.text = @"Соединение с интернетом потеряно :(";
    failLabel.numberOfLines = 0;
    failLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:failLabel];
}

@end
