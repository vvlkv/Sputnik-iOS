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
#import "BUEntityModel+CoreDataClass.h"
#import "BUPairModel+CoreDataClass.h"
#import "BUDayModel+CoreDataClass.h"
#import "BUTeacherModel+CoreDataClass.h"
#import "BUGroupModel+CoreDataClass.h"
#import "BUAuditoryModel+CoreDataClass.h"

#import "SUAISchedule.h"
#import "SUAIEntity.h"
#import "SUAIDay.h"
#import "SUAIPair.h"
#import "SUAIAuditory.h"
#import "SUAITime.h"

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

- (SUAISchedule *)load {
    let *context = [dataManager objectContext];
    let *request = [context executeFetchRequest:[[BUScheduleModel class] fetchRequest] error:nil];
    if (request == nil || [request count] == 0)
        return nil;
    let *result = (BUScheduleModel *)request[0];
    if (result == nil)
        return nil;
    
    var *schedule = [[SUAISchedule alloc] initWithEntity:[self p_loadEntity:[result entityObject]]];
    schedule.semester = [self p_loadDays:[result semester]];
    schedule.session = [self p_loadDays:[result session]];
    return schedule;
}

- (NSManagedObject *)p_initEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    var *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    var *model = [[NSManagedObject alloc]
                                             initWithEntity:entity
                                             insertIntoManagedObjectContext:context];
    return model;
}

- (void)save:(SUAISchedule *)schedule {
    var *context = [dataManager objectContext];
    var *scheduleModel = (BUScheduleModel *)[self p_initEntityWithName:@"BUScheduleModel" inContext:context];
    [scheduleModel setEntityObject:[self p_saveEntity:[schedule entity] inContext:context]];
    
    for (SUAIDay *sessionDay in [schedule session]) {
        [scheduleModel addSessionObject:[self p_saveDay:sessionDay inContext:context]];
    }
    for (SUAIDay *semesterDay in [schedule semester]) {
        [scheduleModel addSemesterObject:[self p_saveDay:semesterDay inContext:context]];
    }
    NSError *error = nil;
    [context save:&error];
}

- (void)clear {
    var *context = [dataManager objectContext];
    var *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:[[BUScheduleModel class] fetchRequest]];
    [context executeRequest:deleteRequest error:nil];
    [context save:nil];
}

- (BUDayModel *)p_saveDay:(SUAIDay *)day inContext:(NSManagedObjectContext *)context {
    var *dayModel = (BUDayModel *)[self p_initEntityWithName:@"BUDayModel" inContext:context];
    dayModel.name = day.name;
    for (SUAIPair *pair in [day pairs]) {
        [dayModel addPairsObject:[self p_savePair:pair inContext:context]];
    }
    return dayModel;
}

- (BUPairModel *)p_savePair:(SUAIPair *)pair inContext:(NSManagedObjectContext *)context {
    var *pairModel = (BUPairModel *)[self p_initEntityWithName:@"BUPairModel" inContext:context];
    pairModel.name = pair.name;
    pairModel.time = [pair.time stringValue];
    pairModel.lessonType = pair.lessonType;
    pairModel.color = (NSUInteger)pair.color;
    for (NSString *teacher in [pair teachers]) {
        var *teacherModel = (BUTeacherModel *)[self p_initEntityWithName:@"BUTeacherModel" inContext:context];
        teacherModel.name = teacher;
        [pairModel addTeachersObject:teacherModel];
    }
    for (NSString *group in [pair groups]) {
        var *groupModel = (BUGroupModel *)[self p_initEntityWithName:@"BUGroupModel" inContext:context];
        groupModel.name = group;
        [pairModel addGroupsObject:groupModel];
    }
    var *auditory = (BUAuditoryModel *)[self p_initEntityWithName:@"BUAuditoryModel" inContext:context];
    auditory.name = [[pair auditory] fullDescription];
    pairModel.auditory = auditory;
    return pairModel;
}

- (BUEntityModel *)p_saveEntity:(SUAIEntity *)entity inContext:(NSManagedObjectContext *)context {
    var *entityModel = (BUEntityModel *)[self p_initEntityWithName:@"BUEntityModel" inContext:context];
    entityModel.name = entity.name;
    entityModel.sessionCode = entity.sessionCode;
    entityModel.semesterCode = entity.semesterCode;
    entityModel.type = (NSUInteger)entity.type;
    return entityModel;
}

- (NSArray<SUAIDay *> *)p_loadDays:(NSOrderedSet<BUDayModel *> *)dayModels {
    NSMutableArray<SUAIDay *> *days = [NSMutableArray array];
    for (BUDayModel *dayModel in dayModels) {
        [days addObject:[[SUAIDay alloc] initWithName:[dayModel name] andPairs:[self p_loadPairs:[dayModel pairs]]]];
    }
    return [days copy];
}

- (NSArray<SUAIPair *> *)p_loadPairs:(NSOrderedSet<BUPairModel *> *)pairModels {
    NSMutableArray<SUAIPair *> *pairs = [NSMutableArray array];
    for (BUPairModel *pairModel in pairModels) {
        var *pair = [[SUAIPair alloc] init];
        pair.name = [pairModel name];
        pair.color = (WeekType)[pairModel color];
        pair.lessonType = [pairModel lessonType];
        pair.time = [[SUAITime alloc] initWithTimeString:[pairModel time]];
        NSMutableArray *contents = [NSMutableArray array];
        for (BUTeacherModel *teacher in [pairModel teachers]) {
            [contents addObject:[teacher name]];
        }
        pair.teachers = [contents copy];
        contents = [NSMutableArray array];
        for (BUGroupModel *group in [pairModel groups]) {
            [contents addObject:[group name]];
        }
        pair.groups = [contents copy];
        var *auditoryModel = [pairModel auditory];
        pair.auditory = [[SUAIAuditory alloc] initWithString:[auditoryModel name]];
        [pairs addObject:pair];
    }
    return [pairs copy];
}

- (SUAIEntity *)p_loadEntity:(BUEntityModel *)entityModel {
    return [[SUAIEntity alloc] initWithName:[entityModel name]
                                sessionCode:[entityModel sessionCode]
                               semesterCode:[entityModel semesterCode]
                                       type:(EntityType)[entityModel type]];
}

@end
