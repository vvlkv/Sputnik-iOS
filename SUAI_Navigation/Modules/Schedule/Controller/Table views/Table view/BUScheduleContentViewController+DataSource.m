//
//  BUScheduleContentViewController+DataSource.m
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleContentViewController+DataSource.h"
#import "BUScheduleTableViewCell.h"
#import "BUPairViewModel.h"

@implementation BUScheduleContentViewController (DataSource)


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:self atIndex:self.index andType:self.type];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    BUScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BUPairViewModel *pair = [self.dataSource pairAtIndex:indexPath.section dayIndex:self.index andType:self.type];
    cell.name = [pair name];
    cell.teacher = [pair subInfo];
    cell.pairType = [pair type];
    return cell;
}

@end
