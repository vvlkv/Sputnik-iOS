//
//  BUReferenceDetailInfoViewController+DataSource.m
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoViewController+DataSource.h"
#import "BUReferenceViewModelItemProtocol.h"
#import "BUReferenceDefaultTableViewCell.h"

@implementation BUReferenceDetailInfoViewController (DataSource)

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self.dataSource tableView:tableView modelForSection:indexPath.section atIndex:indexPath.row];
    return [self cellForTableViewWithModel:model andIndex:indexPath.row];
}

- (UITableViewCell *)cellForTableViewWithModel:(id <BUReferenceViewModelItemProtocol>)model andIndex:(NSUInteger)index {
    NSString *nibName = nil;
    switch ([model ViewModelItemType]) {
        case ViewModelItemHead:
            nibName = @"BUReferenceHeadTableViewCell";
            break;
        case ViewModelItemHeader:
            nibName = @"BUReferenceHeaderTableViewCell";
            break;
        case ViewModelItemCathedral:
            nibName = @"BUReferenceCathedraTableViewCell";
            break;
        case ViewModelItemDefault:
            nibName = @"BUReferenceDefaultTableViewCell";
            break;
        case ViewModelItemLink:
            nibName = @"BUReferenceLinkTableViewCell";
            break;
        case ViewModelItemTime:
            nibName = @"BUReferenceTimeTableViewCell";
            break;
        default:
            break;
    }
    if (nibName != nil) {
        BUReferenceDefaultTableViewCell *cell = (BUReferenceDefaultTableViewCell *)[[NSBundle mainBundle] loadNibNamed:nibName
                                                                                owner:self
                                                                              options:nil][0];
        cell.model = model;
        return cell;
    }
    
    return nil;
}

@end
