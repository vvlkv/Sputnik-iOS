//
//  BUMainStateModel.m
//  SUAI_Navigation
//
//  Created by Виктор on 09.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUMainStateModel.h"

typedef enum MainState {
    MainStateStart,
    MainStateShowAuditory,
    MainStateShowPath
} MainState;

typedef enum LastAuditory {
    LastAuditoryTypeNormal,
    LastAuditoryTypeInverse
} LastAuditoryType;

@interface BUMainStateModel() {
    MainState state;
    LastAuditoryType auditoryType;
    NSUInteger lastSettedAuditory;
    NSMutableArray *auditories;
}

@end

@implementation BUMainStateModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = MainStateStart;
        auditoryType = LastAuditoryTypeNormal;
        auditories = [[NSMutableArray alloc] initWithObjects:@"", @"", nil];
    }
    return self;
}

- (NSArray *)auditories {
    return [auditories copy];
}

- (void)setAuditory:(NSString *)auditory forDirection:(NSUInteger)direction {
    if (![auditories[direction] isEqualToString:@""]) {
        state = MainStateStart;
    }
    
    switch (state) {
        case MainStateStart:
            auditories[direction] = auditory;
            state = MainStateShowAuditory;
            break;
        case MainStateShowAuditory:
            if ([auditories[direction] isEqualToString:@""]) {
                auditoryType = LastAuditoryTypeInverse;
                auditories[direction] = auditory;
                state = MainStateShowPath;
            } else {
                auditories[direction^1] = auditories[direction];
                auditories[direction] = auditory;
            }
            break;
        default:
            auditories[direction] = auditory;
            break;
    }
    lastSettedAuditory = direction;
    if (state != MainStateStart) {
        if (direction == 0) {
            auditoryType = LastAuditoryTypeNormal;
        } else {
            auditoryType = LastAuditoryTypeInverse;
        }
    }
}

- (void)setPathFrom:(NSString *)from to:(NSString *)to {
    auditories[0] = from;
    auditories[1] = to;
    state = MainStateShowPath;
    auditoryType = LastAuditoryTypeNormal;
}

- (void)showNormalPath {
    [self.delegate stateModel:self showPathFrom:auditories[0] to:auditories[1]];
}

- (void)resetAuditoryForDirection:(NSUInteger)direction {
    switch (state) {
        case MainStateStart:
            auditories[direction] = @"";
            break;
        case MainStateShowAuditory:
            auditories[direction] = @"";
            state = MainStateStart;
            break;
        default:
            auditories[direction] = @"";
            state = MainStateShowAuditory;
            break;
    }
    lastSettedAuditory = direction ^ 1;
}

- (BOOL)revertAuditories {
    if (![auditories containsObject:@""]) {
        [auditories addObject:auditories[0]];
        [auditories removeObjectAtIndex:0];
        return YES;
    }
    return NO;
}

- (void)prepareToExecute {
    
    if (![auditories[lastSettedAuditory] isEqualToString:@""]) {
        if ([self.delegate stateModel:self showAuditory:auditories[lastSettedAuditory]] < 0) {
            [self resetAuditoryForDirection:lastSettedAuditory];
        }
    } else if ([auditories[lastSettedAuditory^1] isEqualToString:@""]) {
        [self.delegate resetStateToDefault:self];
    }
    
    if (![auditories containsObject:@""]) {
        [self.delegate showAlertController];
    }
}

@end
