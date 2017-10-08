//
//  BUSettingsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsPresenter.h"
#import "BUSettingsPresenterState.h"
#import "NSArray+Codes.h"

@interface BUSettingsPresenter () {
    BUSettingsPresenterState *state;
}

@end

@implementation BUSettingsPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = [[BUSettingsPresenterState alloc] init];
    }
    return self;
}


#pragma mark - BUSettingsViewControllerOutput

- (void)didPressEntitySettings {
    if ([state.codes count] == 0 || state.isOnline == NO) {
        [self.view showFailureMessage];
    } else {
        NSArray *searchItems = @[[NSArray codesFromDictionary:state.codes[@"Semester"][@"Groups"]],
                                 [NSArray codesFromDictionary:state.codes[@"Semester"][@"Teachers"]]];
        [self.router presentSearchViewControllerWithItems:searchItems fromViewController:(UIViewController *)self.view andPresenter:self];
    }
}

- (void)didSetStartIndex:(NSUInteger)index {
    [self.input overwriteSettingsWithStartIndex:index];
}

- (void)viewDidLoad {
    [self.input obtainCodes];
    [self.view updateSettings];
}

- (void)didPressAboutApp {
    [self.router pushAboutAppViewControllerFromViewController:(UIViewController *)self.view];
}

#pragma mark - BUSettingsInteractorOutput

- (void)didObtainCodes:(NSDictionary *)codes {
    state.codes = codes;
}

- (void)didObtainEntityName:(NSString *)name {
    state.entityName = name;
}

- (void)didObtainEntityType:(NSUInteger)type {
    state.entityType = type;
}

- (void)didObtainStartScreenIndex:(NSUInteger)index {
    state.startScreenIndex = index;
}

- (void)didConnectionBecomReachable {
    state.isOnline = YES;
}

- (void)didConnectionBecomUnreachable {
    state.isOnline = NO;
}

#pragma mark - BUSettingsRouterOutput

- (void)didFoundNewEntity:(NSString *)entity ofType:(NSUInteger)type {
    state.entityName = entity;
    state.entityType = type;
    [self.input overwriteSettingsWithEntiyName:entity andType:type];
    [self.view updateSettings];
}


#pragma mark - BUSettingsViewControllerDataSource

- (NSString *)entityType {
    return ([state entityType] == 0) ? @"Группа" : @"Преподаватель";
}

- (NSString *)entityName {
    return [state entityName];
}

- (NSUInteger)startIndex {
    return [state startScreenIndex];
}

@end
