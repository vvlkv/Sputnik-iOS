//
//  BUReferenceViewController+DataSource.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewController+DataSource.h"
#import "BUReferenceTableViewCell.h"

@implementation BUReferenceViewController (DataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BUReferenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (!cell) {
        cell = (BUReferenceTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"BUReferenceTableViewCell"
                                                                         owner:self
                                                                       options:nil][0];
    }
    cell.name = [self.dataSource titleForCellAtRow:indexPath.row inSection:indexPath.section];
    return cell;
}

@end
