//
//  BUSettingsViewModelStartScreen.m
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewModelStartScreen.h"

@interface BUSettingsViewModelStartScreen() {
    NSArray <NSString *> *contents;
}

@end

@implementation BUSettingsViewModelStartScreen

- (instancetype)init
{
    self = [super init];
    if (self) {
        contents = @[@"Новости", @"Расписание", @"Навигация", @"Справочник"];
    }
    return self;
}

- (NSString *)headerTitle {
    return @"Стартовый экран";
}

- (NSString *)titleForCellAtIndex:(NSUInteger)index {
    return contents[index];
}

- (BUSettingsViewModelItemType)itemType {
    return BUSettingsViewModelItemTypeStartScreen;
}

- (NSUInteger)rowsCount {
    return [contents count];
}

@end
