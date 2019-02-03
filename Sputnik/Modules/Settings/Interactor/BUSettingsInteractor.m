//
//  BUSettingsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsInteractor.h"
#import "BUAppDataContainer.h"
#import "SUAI.h"
#import "SputnikConst.h"

@implementation BUSettingsInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_codesLoaded) name:kSUAIEntityLoadedNotification object:nil];
    }
    return self;
}

- (void)p_codesLoaded {
    NSArray <SUAIEntity *> *groups = [[[SUAI instance] schedule] groups];
    NSArray <SUAIEntity *> *teachers = [[[SUAI instance] schedule] teachers];
    if ([groups count] > 0 && [teachers count] > 0)
        [self.output didObtainCodesGroups:groups andTeachers:teachers];
}

#pragma mark - BUSettingsInteractorInput

- (void)obtainCodes {
    NSString *entity = [[BUAppDataContainer instance] entity];
    [self.output didObtainEntityName:entity];
    
    NSUInteger type = [[BUAppDataContainer instance] type];
    [self.output didObtainEntityType:type];
    
    NSUInteger startIndex = [[BUAppDataContainer instance] startScreenIndex];
    [self.output didObtainStartScreenIndex:startIndex];
    if (![[[SUAI instance] schedule] codesAvailable]) {
        return;
    }
    NSArray <SUAIEntity *> *groups = [[[SUAI instance] schedule] groups];
    NSArray <SUAIEntity *> *teachers = [[[SUAI instance] schedule] teachers];
    [self.output didObtainCodesGroups:groups andTeachers:teachers];
}

- (void)overwriteSettingsWithEntiyName:(NSString *)name andType:(NSUInteger)type {
    [[BUAppDataContainer instance] overwriteEntityWithName:name andType:type];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSputnikDidChangeEntityNotification object:nil];
}

- (void)overwriteSettingsWithStartIndex:(NSUInteger)index {
    [[BUAppDataContainer instance] overwriteStartScreenIndex:index];
    [self.output didObtainStartScreenIndex:index];
}

- (void)dealloc {
    [NSNotificationCenter removeObserver:self forKeyPath:kSUAIEntityLoadedNotification];
}

@end
