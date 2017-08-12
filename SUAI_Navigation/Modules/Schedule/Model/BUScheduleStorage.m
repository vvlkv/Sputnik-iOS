//
//  BUScheduleStorage.m
//  BUSUAIParser
//
//  Created by Виктор on 10.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUScheduleStorage.h"
#import "BUScheduleDataManager.h"

#import "BUScheduleModel+CoreDataClass.h"
#import "BUPairModel+CoreDataClass.h"
#import "BUDayModel+CoreDataClass.h"

#import "BUPair.h"
#import "BUDay.h"

#import <CoreData/CoreData.h>

@interface BUScheduleStorage () {
    BUScheduleDataManager *dataManager;
}

@end


@implementation BUScheduleStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        dataManager = [[BUScheduleDataManager alloc] init];
    }
    return self;
}

- (void)deleteAllEntities {
    NSArray *objects = [self loadScheduleFromDataBaseNoPrint];
    for (id obj in objects) {
        [[dataManager objectContext] deleteObject:obj];
    }
    [[dataManager objectContext] save:nil];
}

- (NSArray *)loadScheduleFromDataBase {
    
    NSMutableArray *schedule = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        [schedule addObject:[NSArray array]];
    }
    
    NSError *reqError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"BUScheduleModel"
                                                   inManagedObjectContext:[dataManager objectContext]];
    
    [request setEntity:description];
    NSArray *answer = [[dataManager objectContext] executeFetchRequest:request error:&reqError];
    NSMutableArray *result = [[NSMutableArray alloc] initWithObjects:[NSArray array], [NSArray array], nil];
    
    for (BUScheduleModel *model in answer) {
        if ([[model name] isEqualToString:@"Semester"]) {
            NSArray *semesterData = [self loadSemester:[model days]];
            [result replaceObjectAtIndex:0 withObject:semesterData];
        } else {
            NSArray *sessionData = [self loadSession:[model days]];
            [result replaceObjectAtIndex:1 withObject:sessionData];
        }
    }
    return result;
}

- (NSArray *)loadScheduleFromDataBaseNoPrint {
    NSError *reqError = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"BUScheduleModel"
                                                   inManagedObjectContext:[dataManager objectContext]];
    
    [request setEntity:description];
      NSArray *result = [[dataManager objectContext] executeFetchRequest:request error:&reqError];
    return result;
}

- (void)writeScheduleToDataBase:(NSArray *)dataBase {
    [self saveSemester:dataBase[0]];
    [self saveSession:dataBase[1]];
    [[dataManager objectContext] save:nil];
}

- (void)saveSession:(NSArray *)session {
    BUScheduleModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"BUScheduleModel"
                                                           inManagedObjectContext:[dataManager objectContext]];
    model.name = @"Session";
    NSMutableArray *days = [NSMutableArray array];
    for (BUDay *day in session) {
        BUDayModel *dayModel = [NSEntityDescription insertNewObjectForEntityForName:@"BUDayModel"
                                                             inManagedObjectContext:[dataManager objectContext]];
        
        dayModel.name = [day day];
        dayModel.index = [session indexOfObject:day];
        NSMutableArray *pairs = [NSMutableArray array];
        for (BUPair *pair in [day pairs]) {
            
            BUPairModel *pairModel = [self convertPair:pair];
            pairModel.index = [[day pairs] indexOfObject:pair];
            [pairs addObject:pairModel];
        }
        [dayModel addPairs:[NSSet setWithArray:pairs]];
        [days addObject:dayModel];
    }
    [model addDays:[NSSet setWithArray:days]];
}

- (void)saveSemester:(NSArray *)semester {
    BUScheduleModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"BUScheduleModel"
                                                           inManagedObjectContext:[dataManager objectContext]];
    model.name = @"Semester";
    NSMutableArray *days = [NSMutableArray array];
    for (BUDay *day in semester) {
        
        BUDayModel *dayModel = [NSEntityDescription insertNewObjectForEntityForName:@"BUDayModel"
                                                             inManagedObjectContext:[dataManager objectContext]];
        
        dayModel.name = [day day];
        dayModel.index = [semester indexOfObject:day];
        NSMutableArray *pairs = [NSMutableArray array];
        
        for (BUPair *pair in [day pairs]) {
            
            BUPairModel *pairModel = [self convertPair:pair];
            pairModel.index = [[day pairs] indexOfObject:pair];
            [pairs addObject:pairModel];
            
        }
        [dayModel addPairs:[NSSet setWithArray:pairs]];
        [days addObject:dayModel];
    }
    [model addDays:[NSSet setWithArray:days]];
}

- (NSArray *)loadSemester:(NSSet *)semester {
    NSMutableArray *semesterSchedule = [NSMutableArray array];
    for (BUDayModel *dayModel in semester) {
        BUDay *day = [[BUDay alloc] initWithDay:[dayModel name]];
        
        NSMutableArray *internalPairs = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[dayModel pairs] count]; i++) {
            [internalPairs addObject:[NSArray array]];
        }
        
        for (BUPairModel *pairModel in [dayModel pairs]) {
            BUPair *pair = [self convertPairModel:pairModel];
            [internalPairs replaceObjectAtIndex:[pairModel index] withObject:pair];
        }
        
        for (BUPair *correctPair in internalPairs) {
            [day addPair:correctPair];
        }
        
        [semesterSchedule addObject:day];
    }
    return semesterSchedule;
}

- (NSArray *)loadSession:(NSSet *)session {
    
    NSMutableArray *sessionSchedule = [NSMutableArray array];
    for (int i = 0; i < [session count]; i++) {
        [sessionSchedule addObject:[NSArray array]];
    }
    for (BUDayModel *dayModel in session) {
        BUDay *day = [[BUDay alloc] initWithDay:[dayModel name]];
        
        NSMutableArray *internalPairs = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[dayModel pairs] count]; i++) {
            [internalPairs addObject:[NSArray array]];
        }
        
        for (BUPairModel *pairModel in [dayModel pairs]) {
            BUPair *pair = [self convertPairModel:pairModel];
            [internalPairs replaceObjectAtIndex:[pairModel index] withObject:pair];
        }
        
        for (BUPair *correctPair in internalPairs) {
            [day addPair:correctPair];
        }
        [sessionSchedule replaceObjectAtIndex:[dayModel index] withObject:day];
    }
    
    
    return sessionSchedule;
}

- (BUPairModel *)convertPair:(BUPair *)pair {
        BUPairModel *pairModel = [NSEntityDescription insertNewObjectForEntityForName:@"BUPairModel"
                                                               inManagedObjectContext:[dataManager objectContext]];
    
    pairModel.name = [pair name];
    pairModel.auditory = [pair auditory];
    pairModel.groups = [pair groups];
    pairModel.teacher = [pair teacherName];
    pairModel.dayColor = (NSUInteger)[pair color];
    pairModel.type = [pair lessonType];
    pairModel.time = [pair time];
    return pairModel;
}

- (BUPair *)convertPairModel:(BUPairModel *)pairModel {
    BUPair *pair = [[BUPair alloc] init];
    pair.name = [pairModel name];
    pair.auditory = [pairModel auditory];
    pair.groups = [pairModel groups];
    pair.teacherName = [pairModel teacher];
    pair.color = (DayColor)[pairModel dayColor];
    pair.lessonType = [pairModel type];
    pair.time = [pairModel time];
    return pair;
}

@end
