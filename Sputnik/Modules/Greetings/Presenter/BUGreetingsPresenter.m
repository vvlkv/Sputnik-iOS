//
//  BUGreetingsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsPresenter.h"
#import "BUGreetingsPresenterState.h"
#import "SUAIEntity.h"

@interface BUGreetingsPresenter () {
    BUGreetingsPresenterState *state;
}

@end


@implementation BUGreetingsPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = [[BUGreetingsPresenterState alloc] init];
    }
    return self;
}


#pragma mark - BUGreetingsViewControllerOutput

- (void)viewDidLoad {
    [self.input obtainCodes];
}

- (void)didSelectEntityType:(NSUInteger)type {
    state.selectedEntitiesIndex = type;
}

- (void)didSelectEntityAtIndex:(NSUInteger)index {
    state.chosenEntityIndex = index;
}

- (void)didConformSelection {
    NSString *entityName = [state.selectedEntities[state.chosenEntityIndex] name];
    [self.input overwriteEntity:entityName andType:state.selectedEntitiesIndex];
}


#pragma mark - BUSecondStepViewDataSource

- (NSUInteger)numberOfItemsForPickerView {
    return [state.selectedEntities count];
}

- (NSString *)pickerViewItemAtIndex:(NSUInteger)index {
    return [[[state.selectedEntities[index] name] componentsSeparatedByString:@" -"] firstObject];
}

- (NSString *)greetingsText {
    return (state.selectedEntitiesIndex == 0) ? @"Выберите группу:" : @"Выберите фамилию:";
}


#pragma mark - BUGreetingsInteractorOutput

- (void)didObtainGroupCodes:(NSArray <SUAIEntity *> *)groupCodes teacherCodes:(NSArray <SUAIEntity *> *)teacherCodes {
    state.sortedCodesArray = @[groupCodes, teacherCodes];
    [self.view initGreetingsView];
}

- (void)didFailConnection {
    if (!state.isFailViewAlreadyInit) {
        [self.view initFailView];
        state.isFailViewAlreadyInit = YES;
    }
}

- (void)didInternetBecomeReachable {
    if (state.isFailViewAlreadyInit) {
        [self.view removeFailView];
    }
}

@end
