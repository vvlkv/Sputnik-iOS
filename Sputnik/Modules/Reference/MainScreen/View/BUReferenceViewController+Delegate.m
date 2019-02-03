//
//  BUReferenceViewController+Delegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewController+Delegate.h"

@implementation BUReferenceViewController (Delegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didPressCellAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
