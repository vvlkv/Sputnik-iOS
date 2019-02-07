//
//  BUSettingsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsPresenter.h"
#import "BUSettingsDataDisplayManager.h"
#import "SUAIEntity.h"

@interface BUSettingsPresenter () {
    NSArray<NSArray <SUAIEntity *> *> *_codes;
    BUSettingsDataDisplayManager *displayManager;
}

@end

@implementation BUSettingsPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        displayManager = [[BUSettingsDataDisplayManager alloc] init];
    }
    return self;
}


#pragma mark - BUSettingsViewControllerOutput

- (void)viewDidLoad {
    [self.input obtainCodes];
    [self.view updateSettings];
}

- (void)didPressEntitySettings {
    if (_codes == nil) {
        [self.view showFailureMessage];
    } else {
        [self.router presentSearchViewControllerFromViewController:(UIViewController *)self.view];
    }
}

- (void)didSetStartIndex:(NSUInteger)index {
    [self.input overwriteSettingsWithStartIndex:index];
    [self.view updateSettings];
}

- (void)didPressAboutApp {
    [self.router pushAboutAppViewControllerFromViewController:(UIViewController *)self.view];
}

- (void)didSelectRow:(NSUInteger)rowIndex atSection:(NSUInteger)sectionIndex {
    BUSettingsViewModelItemType type = [displayManager typeForItemAtIndex:sectionIndex];
    switch (type) {
        case BUSettingsViewModelItemTypeEntity:
            [self didPressEntitySettings];
            break;
        case BUSettingsViewModelItemTypeStartScreen:
            [self didSetStartIndex:rowIndex];
            break;
        case BUSettingsViewModelItemTypeNotificationCenter:
            [self.router pushNotificationCenterFromViewController:(UIViewController *)self.view];
            break;
        case BUSettingsViewModelItemTypeAbout:
            [self didPressAboutApp];
            break;
    }
}

#pragma mark - BUSettingsInteractorOutput

- (void)didObtainCodesGroups:(NSArray<SUAIEntity *> *)groups
                 andTeachers:(NSArray<SUAIEntity *> *)teachers {
    _codes = @[groups, teachers];
}

- (void)didObtainEntityName:(NSString *)name {
    [displayManager entityName:name];
}

- (void)didObtainEntityType:(NSUInteger)type {
    NSString *typeName = [self nameFromType:type];
    [displayManager entityType:typeName];
}

- (void)didObtainStartScreenIndex:(NSUInteger)index {
    displayManager.startScreenIndex = index;
    [self.view setDataSource:displayManager];
}


#pragma mark - BUSettingsRouterOutput

- (void)didFindEntity:(SUAIEntity *)entity {
    var *name = [entity name];
    var type = [entity type];
    [displayManager entityName:[entity name]];
    [displayManager entityType:[self nameFromType:[entity type]]];
    [self.input overwriteSettingsWithEntiyName:name andType:type];
    [self.view updateSettings];
}

- (NSString *)nameFromType:(NSUInteger)type {
    switch (type) {
        case 0:
            return @"Группа";
        case 1:
            return @"Преподаватель";
        default:
             return @"Аудитория";
    }
}

@end
