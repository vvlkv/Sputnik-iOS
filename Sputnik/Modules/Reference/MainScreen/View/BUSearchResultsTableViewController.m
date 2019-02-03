//
//  BUSearchResultsTableViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 28/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSearchResultsTableViewController.h"
#import "BUReferenceTableViewCell.h"

@interface BUSearchResultsTableViewController ()

@end

@implementation BUSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"BUReferenceTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"SearchResultsCellID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUReferenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultsCellID" forIndexPath:indexPath];
    cell.name = [self.dataSource titleForCellAtRow:indexPath.row inSection:indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.f;
}

- (void)reload {
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didPressCellAtIndex:indexPath.row];
}

@end
