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
}MainState;

typedef enum LastAuditory {
    LastAuditoryTypeNormal,
    LastAuditoryTypeInverse
}LastAuditoryType;

@interface BUMainStateModel() {
    MainState state;
    LastAuditoryType auditoryType;
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
    
    if (state != MainStateStart) {
        if (direction == 0) {
            auditoryType = LastAuditoryTypeNormal;
        } else {
            auditoryType = LastAuditoryTypeInverse;
        }
    }
}

- (void)showNormalPath {
    [self.delegate stateModel:self showPathFrom:auditories[0] to:auditories[1]];
}

- (void)resetAuditoryForDirection:(NSUInteger)direction {
    switch (state) {
        case MainStateStart:
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
}

- (void)revertAuditories {
    if (![auditories containsObject:@""]) {
        [auditories addObject:auditories[0]];
        [auditories removeObjectAtIndex:0];
    }
}

- (void)prepareToExecute {
    if (![auditories containsObject:@""]) {
        if (auditoryType == LastAuditoryTypeInverse) {
            [self.delegate stateModel:self showPathFrom:auditories[1] to:auditories[0]];
        } else {
            [self.delegate stateModel:self showPathFrom:auditories[0] to:auditories[1]];
        }
        [self.delegate showAlertController];
    } else if (![auditories[0] isEqualToString:@""]) {
        [self.delegate stateModel:self showAuditory:auditories[0]];
    } else if (![auditories[1] isEqualToString:@""]) {
        [self.delegate stateModel:self showAuditory:auditories[1]];
    } else {
        [self.delegate resetStateToDefault:self];
    }
}

@end
