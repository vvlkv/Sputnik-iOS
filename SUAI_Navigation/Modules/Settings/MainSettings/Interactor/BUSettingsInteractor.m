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
}

@end
