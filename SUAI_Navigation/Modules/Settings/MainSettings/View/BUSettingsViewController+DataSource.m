//
//  BUSettingsViewController+DataSource.m
//  SUAI_Navigation
//
//  Created by Виктор on 23/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController+DataSource.h"

@implementation BUSettingsViewController (DataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUSettingsViewModelItemType type = [self.dataSource itemTypeAtIndex:indexPath.section];
    UITableViewCell *cell;
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    switch (type) {
        case BUSettingsViewModelItemTypeEntity: {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [self.dataSource subTitleForCellAtSection:section andRow:row];
            cell.detailTextLabel.text = [self.dataSource titleForCellAtSection:section andRow:row];
            return cell;
        }
        case BUSettingsViewModelItemTypeStartScreen: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
            cell.textLabel.text = [self.dataSource titleForCellAtSection:section andRow:row];
            if ([self.dataSource startScreenIndex] == row) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
        case BUSettingsViewModelItemTypeAbout: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [self.dataSource titleForCellAtSection:section andRow:row];
            return cell;
        }
        default:
            cell = nil;
            break;
    }
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource titleForHeaderInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

@end
