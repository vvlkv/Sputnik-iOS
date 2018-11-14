//
//  BUScheduleDownloader.m
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleDownloader.h"
#import "BUDownloader.h"
#import "BUSUAIParser.h"
#import "BUAppDataContainer.h"

@interface BUScheduleDownloader () {
    __block NSMutableDictionary *schedule;
    __block NSMutableDictionary *codes;
}

@end

@implementation BUScheduleDownloader

- (instancetype)init
{
    self = [super init];
    if (self) {
        codes = [NSMutableDictionary dictionary];
        schedule = [NSMutableDictionary dictionary];
        [self addObserver:self forKeyPath:@"schedule" options:0 context:nil];
        [self addObserver:self forKeyPath:@"codes" options:0 context:nil];
    }
    return self;
}

- (void)loadCodes {
    NSArray *keys = @[@"Session", @"Semester"];
    for (int i = 0; i < 2; i++) {
        [BUDownloader loadURLWithType:(ScheduleType)i success:^(NSData *data) {
            [self willChangeValueForKey:@"codes"];
            self->codes[keys[i]] = [BUSUAIParser codesFromData:data];
            [self didChangeValueForKey:@"codes"];
        } fail:^(NSString *fail) {
            [self.delegate failedConnection];
        }];
    }
}

- (void)loadScheduleForEntity:(NSString *)entity
                      andType:(NSUInteger)type {
    NSArray *keys = @[@"Session", @"Semester"];
    NSString *entityKey;
    NSDictionary *entityCodes = [[BUAppDataContainer instance] entityCodes];
    for (int i = 0; i < 2; i++) {
        entityKey = (type == 0) ? entityCodes[keys[i]][@"Groups"][entity] : codes[keys[i]][@"Teachers"][entity];
        [BUDownloader loadScheduleOfType:(ScheduleType)i
                                  entity:(EntityType)type
                                entityId:entityKey
                                 success:^(NSData *data) {
                                     [self willChangeValueForKey:@"schedule"];
                                     self->schedule[keys[i]] = [BUSUAIParser scheduleFromData:data];
                                     [self didChangeValueForKey:@"schedule"];
                                } fail:^(NSString *fail) {
                                    [self.delegate failedConnection];
                                }];
    }
}

- (void)loadScheduleForEntity:(NSString *)entity
                       ofType:(NSUInteger)type
                   usingCodes:(NSDictionary *)cds {
    NSArray *keys = @[@"Session", @"Semester"];
    NSString *entityKey;
//    NSDictionary *entityCodes = [[BUAppDataContainer instance] entityCodes];
    for (int i = 0; i < 2; i++) {
        entityKey = (type == 0) ? cds[keys[i]][@"Groups"][entity] : cds[keys[i]][@"Teachers"][entity];
        [BUDownloader loadScheduleOfType:(ScheduleType)i
                                  entity:(EntityType)type
                                entityId:entityKey
                                 success:^(NSData *data) {
                                     [self willChangeValueForKey:@"schedule"];
                                     self->schedule[keys[i]] = [BUSUAIParser scheduleFromData:data];
                                     [self didChangeValueForKey:@"schedule"];
                                 } fail:^(NSString *fail) {
                                     [self.delegate failedConnection];
                                 }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"codes"]) {
        if ([codes count] == 2)
            [self.delegate codesLoaded];
    }
    
    if ([keyPath isEqualToString:@"schedule"]) {
        if ([schedule count] == 2) {
            [self.delegate scheduleLoaded:schedule];
            [schedule removeAllObjects];
        }
    }
}

- (NSDictionary *)codes {
    return codes;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"schedule" context:nil];
    [self removeObserver:self forKeyPath:@"codes" context:nil];
}

@end
