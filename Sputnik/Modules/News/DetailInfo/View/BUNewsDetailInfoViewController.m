//
//  BUNewsDetailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoViewController.h"
#import "SUAINews.h"
#import "UIViewController+Anchor.h"
#import "BUDetailNewsScrollView.h"

@interface BUNewsDetailInfoViewController() {
    UITableView *detailInfoNewsTableView;
    BUDetailNewsScrollView *detailNewsView;
}

@end

@implementation BUNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    detailNewsView = (BUDetailNewsScrollView *)[[NSBundle mainBundle] loadNibNamed:@"BUDetailNewsView" owner:self options:nil][0];
    detailNewsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.output viewDidLoad];
    [self showActivityIndicator];
}


#pragma mark - BUNewsDetailInfoViewControllerInput

- (void)updateContent {
    [self hideActivityIndicator];
    [self hideInternetFailView];
    let *news = [self.dataSource newsModel];
    detailNewsView.date = news.date;
    detailNewsView.header = news.header;
    detailNewsView.image = news.image;
    detailNewsView.subHeader = news.subHeader;
    detailNewsView.text = news.text;
    [self.view addSubview:detailNewsView];
    [[detailNewsView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[detailNewsView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    [[detailNewsView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[detailNewsView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
}

- (void)loadFailed {
    [self hideActivityIndicator];
    [self showInternetFailView];
}

@end
