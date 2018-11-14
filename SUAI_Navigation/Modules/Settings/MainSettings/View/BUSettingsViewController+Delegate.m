//
//  BUSettingsViewController+Delegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController+Delegate.h"

@implementation BUSettingsViewController (Delegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BUSettingsViewModelItemType type = [self.dataSource itemTypeAtIndex:indexPath.section];
    switch (type) {
        case BUSettingsViewModelItemTypeEntity:
            [self.output didPressEntitySettings];
            break;
        case BUSettingsViewModelItemTypeStartScreen:
            [self.output didSetStartIndex:indexPath.row];
            break;
        case BUSettingsViewModelItemTypeAbout:
            [self.output didPressAboutApp];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
