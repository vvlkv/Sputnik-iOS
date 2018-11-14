//
//  BUSettingsViewModel.m
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewModelEntity.h"

@implementation BUSettingsViewModelEntity

- (NSString *)headerTitle {
    return @"";
}

- (NSString *)titleForCellAtIndex:(NSUInteger)index {
    return _name;
}

- (NSString *)subTitleForCellAtIndex:(NSUInteger)index {
    return _type;
}

- (BUSettingsViewModelItemType)itemType {
    return BUSettingsViewModelItemTypeEntity;
}

- (NSUInteger)rowsCount {
    return 1;
}

@end
