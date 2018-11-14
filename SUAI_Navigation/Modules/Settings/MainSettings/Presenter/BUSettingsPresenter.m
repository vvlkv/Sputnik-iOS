//
//  BUSettingsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsPresenter.h"
#import "BUSettingsPresenterState.h"
#import "BUSettingsDataDisplayManager.h"
#import "NSArray+Codes.h"

@interface BUSettingsPresenter () {
    BUSettingsPresenterState *state;
    BUSettingsDataDisplayManager *displayManager;
}

@end

@implementation BUSettingsPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = [[BUSettingsPresenterState alloc] init];
        displayManager = [[BUSettingsDataDisplayManager alloc] init];
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
    [self.view updateSettings];
}

- (void)viewDidLoad {
    [self.input obtainCodes];
    [self.view updateSettings];
}

- (void)didPressAboutApp {
    [self.router pushAboutAppViewControllerFromViewController:(UIViewController *)self.view];
}

- (id)dataSource {
    return displayManager;
}

#pragma mark - BUSettingsInteractorOutput

- (void)didObtainCodes:(NSDictionary *)codes {
    state.codes = codes;
}

- (void)didObtainEntityName:(NSString *)name {
    [displayManager entityName:name];
}

- (void)didObtainEntityType:(NSUInteger)type {
    NSString *typeName = (type == 0) ? @"Группа" : @"Преподаватель";
    [displayManager entityType:typeName];
}

- (void)didObtainStartScreenIndex:(NSUInteger)index {
    [displayManager startScreen:index];
}

- (void)didConnectionBecomReachable {
    state.isOnline = YES;
}

- (void)didConnectionBecomUnreachable {
    state.isOnline = NO;
}

#pragma mark - BUSettingsRouterOutput

- (void)didFoundNewEntity:(NSString *)entity ofType:(NSUInteger)type {
    NSString *typeName = (type == 0) ? @"Группа" : @"Преподаватель";
    [displayManager entityName:entity];
    [displayManager entityType:typeName];
    [self.input overwriteSettingsWithEntiyName:entity andType:type];
    [self.view updateSettings];
}

@end
