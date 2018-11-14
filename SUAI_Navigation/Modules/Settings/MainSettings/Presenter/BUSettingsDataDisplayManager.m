//
//  BUSettingsDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 23/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsDataDisplayManager.h"
#import "BUSettingsViewModelEntity.h"
#import "BUSettingsViewModelAbout.h"
#import "BUSettingsViewModelStartScreen.h"

@interface BUSettingsDataDisplayManager () {
    NSArray <id<BUSettingsViewModelItem>> *contents;
}

@end


@implementation BUSettingsDataDisplayManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        BUSettingsViewModelEntity *entity = [[BUSettingsViewModelEntity alloc] init];
        BUSettingsViewModelStartScreen *startScreen = [[BUSettingsViewModelStartScreen alloc] init];
        BUSettingsViewModelAbout *about = [[BUSettingsViewModelAbout alloc] init];
        contents = @[entity, startScreen, about];
    }
    return self;
}

- (BUSettingsViewModelItemType)itemTypeAtIndex:(NSUInteger)index {
    return [contents[index] itemType];
}

- (void)entityName:(NSString *)name {
    BUSettingsViewModelEntity *entity = (BUSettingsViewModelEntity *)contents[0];
    entity.name = name;
}

- (void)entityType:(NSString *)type {
    BUSettingsViewModelEntity *entity = (BUSettingsViewModelEntity *)contents[0];
    entity.type = type;
}

- (void)startScreen:(NSUInteger)startScreenIndex {
    BUSettingsViewModelStartScreen *scr = (BUSettingsViewModelStartScreen *)contents[1];
    scr.startScreenIndex = startScreenIndex;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return [contents[section] rowsCount];
}

- (NSUInteger)numberOfSections {
    return [contents count];
}

- (NSString *)titleForHeaderInSection:(NSUInteger)index {
    return [contents[index] headerTitle];
}

- (NSString *)titleForCellAtSection:(NSUInteger)section andRow:(NSUInteger)row {
    return [contents[section] titleForCellAtIndex:row];
}

- (NSString *)subTitleForCellAtSection:(NSUInteger)section andRow:(NSUInteger)row {
    return [contents[section] subTitleForCellAtIndex:row];
}

- (NSUInteger)startScreenIndex {
    return [(BUSettingsViewModelStartScreen *)contents[1] startScreenIndex];
}


@end
