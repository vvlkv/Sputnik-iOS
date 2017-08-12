//
//  BUNewsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsViewController.h"
#import "BUNews.h"
#import "BUNewsTableViewCell.h"

@interface BUNewsViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *newsTableView;
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation BUNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(self.view.frame.size.width/2 - 10, self.view.frame.size.height/2 - 10 - 64, 20, 20);
    indicatorView.hidesWhenStopped = YES;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49);
    self.title = @"Новости";
    newsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    newsTableView.dataSource = self;
    newsTableView.delegate = self;
    [self.output viewDidLoad];
    newsTableView.estimatedRowHeight = 100.f;
    UINib *cellNib = [UINib nibWithNibName:@"BUNewsTableViewCell" bundle:nil];
    [newsTableView registerNib:cellNib forCellReuseIdentifier:@"cellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    [self.view addSubview:newsTableView];
    [indicatorView stopAnimating];
}

- (void)failedConnection {
    UILabel *failLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 30)];
    failLabel.text = @"Соединение с интернет потеряно :(";
    failLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:failLabel];
    [indicatorView stopAnimating];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    BUNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BUNews *news = [self.dataSource newsAtIndex:indexPath.row];
    cell.date = news.date;
    cell.text = news.text;
    cell.header = news.header;
    cell.image = news.image;
    return cell;
}

@end
