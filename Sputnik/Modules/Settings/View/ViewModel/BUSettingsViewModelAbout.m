//
//  BUSettingsViewModelAbout.m
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewModelAbout.h"

@implementation BUSettingsViewModelAbout


- (NSString *)headerTitle {
    return @"";
}

- (NSString *)titleForCellAtIndex:(NSUInteger)index {
    return @"О приложении";
}

- (BUSettingsViewModelItemType)itemType {
    return BUSettingsViewModelItemTypeAbout;
}

- (NSUInteger)rowsCount {
    return 1;
}

@end
