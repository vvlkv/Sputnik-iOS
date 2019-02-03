//
//  BUScheduleNewInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleInteractor.h"
#import "SUAI.h"
#import "SUAIError.h"
#import "BUAppDataContainer.h"
#import "BUScheduleInteractorOutput.h"
#import "BUScheduleStorage.h"
#import "SUAISchedule.h"
#import "BUDateFormatter.h"
#import "NSCalendar+CurrentDay.h"

#import "SputnikConst.h"

@interface BUScheduleInteractor()

@property (nonatomic, strong) BUScheduleStorage *storage;

@end

@implementation BUScheduleInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [[BUScheduleStorage alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_codesLoaded)
                                                     name:kSUAIEntityLoadedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_internetReachabilityChanged:)
                                                     name:kSUAIReachabilityNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_weekTypeObtained)
                                                     name:kSUAIWeekTypeObtainedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_entityChanged)
                                                     name:kSputnikDidChangeEntityNotification object:nil];
    }
    return self;
}

- (void)p_codesLoaded {
    [self.output didLoadCodes];
}

- (void)p_internetReachabilityChanged:(NSNotification *)notification {
    BOOL isReachable = [(NSNumber *)[notification object] boolValue];
    [self.output didChangeInternetReachability:isReachable];
}

- (void)p_weekTypeObtained {
    NSUInteger weekType = [[[SUAI instance] schedule] currentWeekType];
    [self.output didObtainWeekIndex:weekType];
    NSArray const *dateComponents = [BUDateFormatter dateFromWeek:weekType];
    if ([dateComponents count] == 2) {
        [self.output didObtainDate:dateComponents[0] andWeek:dateComponents[1]];
    }
    [[BUAppDataContainer instance] overwriteWeekType:weekType];
}

- (void)p_entityChanged {
    NSString *name = [[BUAppDataContainer instance] entity];
    NSUInteger type = [[BUAppDataContainer instance] type];
    [self.output didChangeEntityName:name andType:type];
}

- (void)writeScheduleToCoreData:(SUAISchedule *)schedule {
    [_storage clear];
    [_storage save:schedule];
}


#pragma mark - BUScheduleNewInteractorInput

- (void)obtainScheduleFromNetworkForEntity:(NSString *)entity type:(NSUInteger)type {
    __weak typeof(self) welf = self;
    [[[SUAI instance] schedule] loadScheduleFor:entity ofType:type success:^(SUAISchedule *schedule) {
        [welf.output didObtainSchedule:schedule];
    } fail:^(__kindof SUAIError *error) {
        if (error.code != SUAIErrorEntityNotAvailable || ![SUAI instance].isReachable)
            [welf.output didScheduleFaultLoading];
    }];
}

- (void)obtainScheduleFromCoreDataForEntity:(NSString *)entity type:(NSUInteger)type {
    [self.output didObtainSchedule:[_storage load]];
}

- (void)obtainDate {
    let weekType = [[BUAppDataContainer instance] weekType];
    let *dateComponents = [BUDateFormatter dateFromWeek:weekType];
    if ([dateComponents count] == 2) {
        [self.output didObtainDate:dateComponents[0] andWeek:dateComponents[1]];
    }
}

- (void)obtainDayIndex {
    [self.output didObtainDayIndex:[NSCalendar currentDay]];
}

- (void)obtainWeekIndex {
    NSUInteger weekType = [[BUAppDataContainer instance] weekType];
    [self.output didObtainWeekIndex:weekType];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIEntityLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIReachabilityNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIWeekTypeObtainedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSputnikDidChangeEntityNotification object:nil];
}

@end
