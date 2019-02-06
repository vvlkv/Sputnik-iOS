//
//  BUGreetingsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsInteractor.h"
#import "BUGreetingsInteractorOutput.h"
#import "BUAppDataContainer.h"
#import "SUAI.h"
#import "SputnikConst.h"

@interface BUGreetingsInteractor () {
    BOOL internetWasUnreachable;
}

@end

@implementation BUGreetingsInteractor

#pragma mark - BUGreetingsInteractorInput

- (void)obtainCodes {
    var *groups = [[[SUAI instance] schedule] groups];
    var *teachers = [[[SUAI instance] schedule] teachers];
    if ([groups count] > 0 && [teachers count] > 0)
        [self.output didObtainGroupCodes:groups teacherCodes:teachers];
}

- (void)overwriteEntity:(NSString *)entity
                andType:(NSUInteger)type {
    [[BUAppDataContainer instance] overwriteEntityWithName:entity andType:type];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSputnikDidChangeEntityNotification
                                                        object:nil];
}

@end
