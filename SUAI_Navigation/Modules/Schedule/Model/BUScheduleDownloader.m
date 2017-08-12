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
#import "BUSUAIParser+Date.h"

@interface BUScheduleDownloader () {
    __block NSMutableDictionary *schedule;
    __block NSMutableDictionary *codes;
    __block NSString *date;
}

@end

@implementation BUScheduleDownloader



- (instancetype)init
{
    self = [super init];
    if (self) {
        codes = [NSMutableDictionary dictionary];
        schedule = [NSMutableDictionary dictionary];
        date = @"";
        [self addObserver:self forKeyPath:@"schedule" options:0 context:nil];
        [self addObserver:self forKeyPath:@"codes" options:0 context:nil];
        
        [self loadCodes];
    }
    return self;
}

- (void)loadCodes {
    NSArray *keys = @[@"Session", @"Semester"];
    for (int i = 0; i < 2; i++) {
        [BUDownloader loadURLWithType:(ScheduleType)i success:^(NSData *data) {
            [self willChangeValueForKey:@"codes"];
            codes[keys[i]] = [BUSUAIParser codesFromData:data];
            if (i == 1)
                date = [BUSUAIParser dateFromData:data];
            [self didChangeValueForKey:@"codes"];
        } fail:^(NSString *fail) {
            [self.delegate failedConnection];
        }];
    }
}

- (void)downloadScheduleForEntity:(NSString *)entity
                                    andType:(NSUInteger)type {
    NSArray *keys = @[@"Session", @"Semester"];
    NSString *entityKey;
    for (int i = 0; i < 2; i++) {
        entityKey = (type == 0) ? codes[keys[i]][@"Groups"][entity] : codes[keys[i]][@"Teachers"][entity];
        [BUDownloader loadScheduleOfType:(ScheduleType)i
                                  entity:(EntityType)type
                                entityId:entityKey
                                 success:^(NSData *data) {
                                     [self willChangeValueForKey:@"schedule"];
                                     schedule[keys[i]] = [BUSUAIParser scheduleFromData:data];
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
            [self.delegate dataLoaded:schedule];
            [schedule removeAllObjects];
        }
    }
}

- (NSDictionary *)codes {
    return codes;
}

- (NSString *)date {
    return date;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"schedule" context:nil];
    [self removeObserver:self forKeyPath:@"codes" context:nil];
}

@end
