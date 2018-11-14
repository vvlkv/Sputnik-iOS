//
//  BUSettingsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsInteractor.h"
#import "BUAppDataContainer.h"

@implementation BUSettingsInteractor


#pragma mark - BUSettingsInteractorInput

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachable:)
                                                     name:@"buInternetBecomeReachable"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notReachable:)
                                                     name:@"buInternetBecomeUnreachable"
                                                   object:nil];
    }
    return self;
}

- (void)obtainCodes {
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    NSString *entity = [[BUAppDataContainer instance] entity];
    NSUInteger type = [[BUAppDataContainer instance] type];
    NSUInteger startIndex = [[BUAppDataContainer instance] startScreenIndex];
    [self.output didObtainCodes:codes];
    [self.output didObtainEntityName:entity];
    [self.output didObtainEntityType:type];
    [self.output didObtainStartScreenIndex:startIndex];
}

- (void)overwriteSettingsWithEntiyName:(NSString *)name andType:(NSUInteger)type {
    [[BUAppDataContainer instance] overwriteEntityWithName:name andType:type];
}

- (void)overwriteSettingsWithStartIndex:(NSUInteger)index {
    [[BUAppDataContainer instance] overwriteStartScreenIndex:index];
    [self.output didObtainStartScreenIndex:index];
}

- (void)reachable:(NSNotification *)notification {
    [self.output didConnectionBecomReachable];
}

- (void)notReachable:(NSNotification *)notification {
    [self.output didConnectionBecomUnreachable];
}

@end
