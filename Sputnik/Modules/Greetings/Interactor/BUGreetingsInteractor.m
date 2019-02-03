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

- (instancetype)init {
    self = [super init];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(p_internetReachabilityChanged:)
//                                                     name:kSUAIReachabilityNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(p_codesLoaded)
//                                                     name:kSUAIEntityLoadedNotification object:nil];
    }
    return self;
}

//- (void)p_internetReachabilityChanged:(NSNotification *)notification {
//    BOOL isReachable = [[notification object] boolValue];
//    if (!isReachable) {
//        [self.output didFailConnection];
//    }
//}

//- (void)p_codesLoaded {
//    [self.output didObtainGroupCodes:[[[SUAI instance] schedule] groups]
//                        teacherCodes:[[[SUAI instance] schedule] teachers]];
//}

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

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIReachabilityNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIEntityLoadedNotification object:nil];
}

@end
