//
//  BUNotificationCenter.m
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationCenter.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import "BUNotificationSettings.h"
#import "BUScheduleStorage.h"
#import "SUAI.h"
#import "SUAISchedule.h"
#import "SUAIDay.h"
#import "SUAIPair.h"
#import "SUAITime.h"
#import "SUAIAuditory.h"

#import "SputnikConst.h"

@interface BUNotificationCenter() {
    UNUserNotificationCenter *_defaultCenter;
    WeekType _currentWeekType;
}

@property (nonatomic, readwrite) BOOL isSystemGranted;

@end

static NSString *const accessRequestedName = @"accessRequested";
static NSString *const isNotificationsAllowedName = @"isNotificationsAllowed";
static NSString *const notifyDayName = @"notifyDay";
static NSString *const notifyPairName = @"notifyPair";
static NSString *const notifyPairTimeName = @"notifyPairTime";
static NSUInteger const minutesInHour = 60;

@implementation BUNotificationCenter

+ (instancetype)instance {
    static BUNotificationCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[[self class] alloc] initPrivate];
    });
    return center;
}

- (instancetype)init {
    assert("init deprecated! use instance");
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _defaultCenter = [UNUserNotificationCenter currentNotificationCenter];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_notificationsSettingsChanged)
                                                     name:kSputnikApplicationDidBecomeActive
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_weekTypeObtained)
                                                     name:kSUAIWeekTypeObtainedNotification object:nil];
        __weak typeof(self) welf = self;
        [_defaultCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            welf.isSystemGranted = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
        }];
    }
    return self;
}


- (void)p_notificationsSettingsChanged {
    __weak typeof(self) welf = self;
    [_defaultCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        welf.isSystemGranted = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
        dispatch_async(dispatch_get_main_queue(), ^{
            [welf.output didChangeNotificationPermission:[welf isSystemGranted]];
        });
    }];
}

- (void)p_weekTypeObtained {
    _currentWeekType = [[[SUAI instance] schedule] currentWeekType];
    var *storage = [[BUScheduleStorage alloc] init];
    [self commitNotificationsWithSchedule:[storage load]];
}

- (void)p_clearNotifications {
    [_defaultCenter removeAllPendingNotificationRequests];
}

- (UNMutableNotificationContent *)p_createNotificationContentForPair:(SUAIPair *)pair timeBefore:(NSUInteger)time {
    var *content = [[UNMutableNotificationContent alloc] init];
    NSString *minuteName = @"минут";
    if (time == 1)
        minuteName = @"минуту";
    if (time > 1 && time < 5)
        minuteName = @"минуты";
    NSString *partOfText = [NSString stringWithFormat:@"Через %zd %@", time, minuteName];
    if (time == 0)
        partOfText = @"Cейчас";
    content.title = [NSString stringWithFormat:@"%@ на пару", partOfText];
    content.body = [NSString stringWithFormat:@"(%@) - %@ - %@", [pair lessonType], [pair name], [[pair auditory] fullDescription]];
    content.sound = [UNNotificationSound defaultSound];
    return content;
}

- (UNMutableNotificationContent *)p_createNotificationContentForDay {
    var *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString stringWithFormat:@"Сегодня на учебу!"];
    content.body = [NSString stringWithFormat:@"Зайди в приложение и проверь расписание сегодняшнего дня"];
    content.sound = [UNNotificationSound defaultSound];
    return content;
}

- (UNCalendarNotificationTrigger *)p_createNotificationTriggerForWeekday:(NSUInteger)weekday
                                                                    time:(NSUInteger)time {
    var *components = [[NSDateComponents alloc] init];
    components.weekday = weekday;
    components.hour = time / minutesInHour;
    components.minute = time % minutesInHour;
    var *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:true];
    return calendarTrigger;
}

- (void)p_registerNotificationForPairs:(NSArray<SUAIPair *> *)pairs
                               weekday:(NSUInteger)weekday
                         minutesBefore:(NSUInteger)time {
    for (SUAIPair *pair in pairs) {
        if ([self p_canRegisterPairWithType:[pair color] onWeekday:weekday]) {
            var *content = [self p_createNotificationContentForPair:pair timeBefore:time];
            let timeBefore = [[pair time] minutesSinceMidnight] - time;
            var *calendarTrigger = [self p_createNotificationTriggerForWeekday:weekday time:timeBefore];
            var *identifier = [NSString stringWithFormat:@"pair:%lu", (unsigned long)[pair hash]];
            var *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:calendarTrigger];
            [_defaultCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            }];
        }
    }
}

- (BOOL)p_canRegisterPairWithType:(WeekType)type onWeekday:(NSUInteger)weekday {
    if (type == WeekTypeBoth)
        return true;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    let currentWeekday = [calendar component:NSCalendarUnitWeekday fromDate:[NSDate date]];
    if (currentWeekday <= weekday) {
        if (type == _currentWeekType)
            return true;
    } else {
        if (type != _currentWeekType)
            return true;
    }
    return false;
}


- (void)p_registerNotificationForDayAtWeekday:(NSUInteger)weekday withHash:(NSUInteger)hash {
    var *content = [self p_createNotificationContentForDay];
    var *calendarTrigger = [self p_createNotificationTriggerForWeekday:weekday time:0];
    var *identifier = [NSString stringWithFormat:@"day:%lu", (unsigned long)hash];
    var *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:calendarTrigger];
    [_defaultCenter addNotificationRequest:request withCompletionHandler:nil];
}

- (void)activatePermissions {
    if ([self accessRequested])
        return;
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
    __weak typeof(self) welf = self;
    [_defaultCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        welf.isSystemGranted = granted;
    }];
    self.accessRequested = YES;
}

- (BUNotificationSettings *)currentSettings {
    var *settings = [[BUNotificationSettings alloc] init];
    settings.isGranted = [self isNotificationAllowed];
    settings.isNotifyPair = [self isNotifyPair];
    settings.isNotifyDay = [self isNotifyDay];
    settings.pairNotifyTime = [self notifyPairBeforeTime];
    return settings;
}

- (void)commitNotificationsWithSchedule:(SUAISchedule *)schedule {
    if (schedule == nil)
        return;
    [self commitNotificationsSettings:[self currentSettings] withSchedule:schedule];
}

- (void)commitNotificationsSettings:(BUNotificationSettings *)settings
                       withSchedule:(SUAISchedule *)schedule {
    if (schedule == nil)
        return;
    self.isNotificationAllowed = [settings isGranted];
    self.isNotifyDay = [settings isNotifyDay];
    self.isNotifyPair = [settings isNotifyPair];
    self.notifyPairBeforeTime = [settings pairNotifyTime];
    [self p_clearNotifications];
    if (![settings isGranted] || ![self isSystemGranted])
        return;
    if ([settings isNotifyPair]) {
        let *semester = [schedule semester];
        for (SUAIDay *day in semester) {
            if ([day weekday] == 1)
                continue;
            if ([settings isNotifyDay])
                [self p_registerNotificationForDayAtWeekday:[day weekday] withHash:[day hash]];
            if ([settings isNotifyPair])
                [self p_registerNotificationForPairs:[day pairs]
                                             weekday:[day weekday]
                                       minutesBefore:[settings pairNotifyTime]];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIWeekTypeObtainedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSputnikApplicationDidBecomeActive object:nil];
}

#pragma mark - Access

- (void)setAccessRequested:(BOOL)accessRequested {
    [[NSUserDefaults standardUserDefaults] setObject:@(accessRequested) forKey:accessRequestedName];
}

- (BOOL)accessRequested {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:accessRequestedName];
    if (obj == nil)
        return NO;
    return [obj boolValue];
}

- (void)setIsNotificationAllowed:(BOOL)isNotificationAllowed {
    [[NSUserDefaults standardUserDefaults] setObject:@(isNotificationAllowed) forKey:isNotificationsAllowedName];
}

- (BOOL)isNotificationAllowed {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:isNotificationsAllowedName];
    if (obj == nil)
        return NO;
    return [obj boolValue];
}

- (void)setIsNotifyDay:(BOOL)isNotifyDay {
    [[NSUserDefaults standardUserDefaults] setObject:@(isNotifyDay) forKey:notifyDayName];
}

- (BOOL)isNotifyDay {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:notifyDayName];
    if (obj == nil)
        return NO;
    return [obj boolValue];
}

- (void)setIsNotifyPair:(BOOL)isNotifyPair {
    [[NSUserDefaults standardUserDefaults] setObject:@(isNotifyPair) forKey:notifyPairName];
}

- (BOOL)isNotifyPair {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:notifyPairName];
    if (obj == nil)
        return NO;
    return [obj boolValue];
}

- (void)setNotifyPairBeforeTime:(NSUInteger)notifyPairBeforeTime {
    [[NSUserDefaults standardUserDefaults] setObject:@(notifyPairBeforeTime) forKey:notifyPairTimeName];
}

- (NSUInteger)notifyPairBeforeTime {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:notifyPairTimeName];
    if (obj == nil)
        return 10;
    return [obj unsignedIntegerValue];
}

@end
