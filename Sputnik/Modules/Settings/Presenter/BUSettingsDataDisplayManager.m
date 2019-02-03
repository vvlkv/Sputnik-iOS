//
//  BUSettingsDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 23/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsDataDisplayManager.h"
#import "BUSettingsViewModelEntity.h"
#import "BUSettingsViewModelStartScreen.h"
#import "BUSettingsViewModelAbout.h"

@interface BUSettingsDataDisplayManager () {
    NSArray <id<BUSettingsViewModelItem>> *contents;
}

@end

static NSString *const cellIdentifier = @"CellID";

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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contents[section] rowsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUSettingsViewModelItem> focusedContent = contents[indexPath.section];
    UITableViewCell *cell;
    NSUInteger row = indexPath.row;
    BUSettingsViewModelItemType type = [focusedContent itemType];
    var *title = [focusedContent titleForCellAtIndex:row];
    switch (type) {
        case BUSettingsViewModelItemTypeEntity: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [focusedContent subTitleForCellAtIndex:row];
            cell.detailTextLabel.text = title;
            return cell;
        }
        case BUSettingsViewModelItemTypeStartScreen: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.textLabel.text = title;
            if ([self startScreenIndex] == row) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
        case BUSettingsViewModelItemTypeAbout: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = title;
            return cell;
        }
        default:
            return nil;
    }
}


- (BUSettingsViewModelItemType)typeForItemAtIndex:(NSUInteger)index {
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

- (void)setStartScreenIndex:(NSUInteger)startScreenIndex {
    BUSettingsViewModelStartScreen *scr = (BUSettingsViewModelStartScreen *)contents[1];
    scr.startScreenIndex = startScreenIndex;
}

- (NSUInteger)startScreenIndex {
    return [(BUSettingsViewModelStartScreen *)contents[1] startScreenIndex];
}

@end
