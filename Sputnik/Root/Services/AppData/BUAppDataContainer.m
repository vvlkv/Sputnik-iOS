//
//  BUAppDataContainer.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAppDataContainer.h"
//#import "BUScheduleDownloader.h"
#import "NSCalendar+CurrentDay.h"


@implementation BUAppDataContainer

+ (instancetype)instance {
    static BUAppDataContainer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)writeWeekType:(NSUInteger)week {
    [[NSUserDefaults standardUserDefaults] setObject:@(week) forKey:@"lastSavedWeekType"];
}

- (void)overwriteEntityWithName:(NSString *)name andType:(NSUInteger)type {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Entity"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (unsigned long)type] forKey:@"Type"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buSettingsChanged" object:self];
}

- (void)overwriteStartScreenIndex:(NSUInteger)index {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (unsigned long)index] forKey:@"StartScreenIndex"];
}

- (void)overwriteWeekType:(NSUInteger)weekType {
    [[NSUserDefaults standardUserDefaults] setObject:@(weekType) forKey:@"currentWeekType"];
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
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentWeekType"];
    if (obj == nil) {
        return [NSCalendar weekIndex];
    }
    NSUInteger week = [obj integerValue];
    return week;
}

@end
