//
//  BUReferenceDetailInfoViewController+Delegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoViewController+Delegate.h"
#import "BUReferenceTableView.h"
#import "BUReferenceDetailInfoViewController.h"
#import "BUReferenceViewModelItemProtocol.h"

@implementation BUReferenceDetailInfoViewController (Delegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.dataSource tableView:tableView modelForSection:indexPath.section atIndex:indexPath.row] isSelectable];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = [indexPath row];
    id <BUReferenceViewModelItemProtocol> model = [self.dataSource tableView:tableView modelForSection:indexPath.section atIndex:indexPath.row];
    switch ([model actionType]) {
        case ReferenceActionTypeAbout:
            [self.output didPressOnAbout];
            break;
        case ReferenceActionTypeEntity:
            [self.output didPressOnEntityAdIndex:index - 1];
        default:
            [self.output didPerformActionWithItem:model];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
