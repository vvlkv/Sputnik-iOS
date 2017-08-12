//
//  BUGreetingsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsPresenter.h"
#import "BUGreetingsPresenterState.h"
#import "NSArray+Codes.h"

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

- (void)didObtainEntitiesAtIndex:(NSUInteger)index {
    state.selectedEntitiesIndex = index;
    [self.view reloadData];
}

- (void)didConformedSelection {
    NSString *entity = state.sortedCodesArray[state.selectedEntitiesIndex][state.chosenEntityIndex];
    [self.input overwriteEntity:entity andType:state.selectedEntitiesIndex];
}

- (void)didEntitySelectedAtIndex:(NSUInteger)index {
    state.chosenEntityIndex = index;
}


#pragma mark - BUSecondStepViewDataSource

- (NSUInteger)numberOfItemsForPickerView {
    return [state.sortedCodesArray[state.selectedEntitiesIndex] count];
}

- (NSString *)pickerViewItemAtIndex:(NSUInteger)index {
    return [state.sortedCodesArray[state.selectedEntitiesIndex][index] componentsSeparatedByString:@" - "][0];
}

- (NSString *)greetingsText {
    if (state.selectedEntitiesIndex == 0) {
        return @"Выберите группу:";
    } else {
        return @"Выберите фамилию:";
    }
}


#pragma mark - BUGreetingsInteractorOutput

- (void)didObtainCodes:(NSDictionary *)codes {
    state.codes = codes;
    state.sortedCodesArray = @[[NSArray codesFromDictionary:state.codes[@"Semester"][@"Groups"]],
                               [NSArray codesFromDictionary:state.codes[@"Semester"][@"Teachers"]]];
    [self.view initGreetingsView];
}

- (void)didFailConnection {
    [self.view initFailView];
}

@end
