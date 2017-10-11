//
//  BUAppDataContainer.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAppDataContainer.h"

@interface BUAppDataContainer () {
    NSDictionary *pCodes;
}

@end

@implementation BUAppDataContainer

- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        pCodes = [NSDictionary dictionary];
    }
    return self;
}

+ (instancetype)instance {
    static BUAppDataContainer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] initPrivate];
    });
    return instance;
}

- (NSDictionary *)entityCodes {
    return [pCodes copy];
}

- (void)writeWeekType:(NSUInteger)week {
    [[NSUserDefaults standardUserDefaults] setObject:@(week) forKey:@"lastSavedWeekType"];
}

- (void)writeCodes:(NSDictionary *)codes {
    if ([pCodes count] == 0) {
        pCodes = [codes copy];
    }
}

- (void)overwriteEntityWithName:(NSString *)name andType:(NSUInteger)type {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Entity"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (unsigned long)type] forKey:@"Type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buSettingsChanged" object:self];
}

- (void)overwriteStartScreenIndex:(NSUInteger)index {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (unsigned long)index] forKey:@"StartScreenIndex"];
}

#pragma mark - Getters

- (NSString *)entity {
    NSString *currentEntity = [[NSUserDefaults standardUserDefaults] objectForKey:@"Entity"];
    return currentEntity;
}

- (NSUInteger)type {
    NSUInteger currentType = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Type"] integerValue];
    return currentType;
}

- (NSUInteger)startScreenIndex {
    NSUInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:@"StartScreenIndex"] integerValue];
    return index;
}

- (NSUInteger)weekType {
    NSUInteger week = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastSavedWeekType"] integerValue];
    return week;
}

@end
