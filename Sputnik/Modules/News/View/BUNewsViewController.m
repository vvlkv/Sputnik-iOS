//
//  BUNewsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsViewController.h"
#import "SUAINews.h"
#import "BUNewsTableViewCell.h"

#import "UIViewController+Anchor.h"

@interface BUNewsViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *newsTableView;
}

@end

NSString *const newsCellName = @"BUNewsTableViewCell";
NSString *const cellIdentifier = @"cellID";

@implementation BUNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configureNewsTableView];
    [self showActivityIndicator];
    [self.output viewDidLoad];
}


#pragma mark - Private

- (void)p_configureNewsTableView {
    self.title = @"Новости";
    self.automaticallyAdjustsScrollViewInsets = YES;
    newsTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStylePlain];
    newsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    newsTableView.dataSource = self;
    newsTableView.delegate = self;
    newsTableView.estimatedRowHeight = 100.f;
    UINib *cellNib = [UINib nibWithNibName:newsCellName bundle:nil];
    [newsTableView registerNib:cellNib forCellReuseIdentifier:cellIdentifier];
    newsTableView.hidden = YES;
    [self.view addSubview:newsTableView];
    [[newsTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[newsTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[newsTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[newsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectedCellAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateContent {
    [self hideActivityIndicator];
    [self hideFailView];
    newsTableView.hidden = NO;
    [newsTableView reloadData];
}

//- (void)showFailMessage {
//    [self hideActivityIndicator];
//    [self showFailView:@"Отсутствует подключение к сети :(" withButton:NO];
//}

- (void)showFailMessageWithText:(NSString *)text {
    [self hideActivityIndicator];
    [self showFailView:text withButton:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    SUAINews *news = [self.dataSource newsAtIndex:indexPath.row];
    cell.date = news.date;
    cell.header = news.header;
    cell.image = news.image;
    return cell;
}

@end
