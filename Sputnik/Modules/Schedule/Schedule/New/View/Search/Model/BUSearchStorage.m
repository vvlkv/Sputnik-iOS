//
//  BUSearchStorage.m
//  Sputnik
//
//  Created by Виктор on 03/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSearchStorage.h"

#import "BUScheduleDataManager.h"
#import "BURecentlySearchResultsModel+CoreDataClass.h"
#import "BUEntityModel+CoreDataClass.h"

#import "SUAIEntity.h"

@interface BUSearchStorage() {
    BUScheduleDataManager *dataManager;
}

@end

@implementation BUSearchStorage

- (instancetype)init {
    self = [super init];
    if (self) {
        dataManager = [[BUScheduleDataManager alloc] init];
    }
    return self;
}

- (NSManagedObject *)p_initEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    var *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    var *model = [[NSManagedObject alloc]
                  initWithEntity:entity
                  insertIntoManagedObjectContext:context];
    return model;
}

- (void)save:(SUAIEntity *)entity {
    var *context = [dataManager objectContext];
    let *request = [context executeFetchRequest:[[BURecentlySearchResultsModel class] fetchRequest]
                                          error:nil];
    BURecentlySearchResultsModel *recentlyModel;
    if ([request count] == 0 || request == nil) {
        recentlyModel = (BURecentlySearchResultsModel *)[self p_initEntityWithName:@"BURecentlySearchResultsModel" inContext:context];
    } else {
        recentlyModel = (BURecentlySearchResultsModel *)request[0];
    }
    for (BUEntityModel *entityModel in [recentlyModel recentlySearch]) {
        if ([[entityModel name] isEqualToString:[entity name]])
            return;
    }
    BUEntityModel *newSearchRes = (BUEntityModel *)[self p_initEntityWithName:@"BUEntityModel" inContext:context];
    newSearchRes.name = [entity name];
    newSearchRes.sessionCode = [entity sessionCode];
    newSearchRes.semesterCode = [entity semesterCode];
    newSearchRes.type = (NSUInteger)[entity type];
    [recentlyModel addRecentlySearchObject:newSearchRes];
    [context save:nil];
    if ([[recentlyModel recentlySearch] count] > 3) {
        [context deleteObject:(NSManagedObject *)[recentlyModel recentlySearch].firstObject];
        [context save:nil];
    }
}

- (NSArray<SUAIEntity *> *)load {
    var *context = [dataManager objectContext];
    let *request = [context executeFetchRequest:[[BURecentlySearchResultsModel class] fetchRequest]
                                          error:nil];
    NSMutableArray *retArray = [NSMutableArray array];
    if ([request count] == 0 || request == nil) {
        return [retArray copy];
    }
    BURecentlySearchResultsModel *recentlyModel = (BURecentlySearchResultsModel *)request[0];
    
    for (BUEntityModel *entityModel in [recentlyModel recentlySearch]) {
        SUAIEntity *entity = [[SUAIEntity alloc] initWithName:[entityModel name]
                                                  sessionCode:[entityModel sessionCode]
                                                 semesterCode:[entityModel semesterCode]
                                                         type:(EntityType)[entityModel type]];
        [retArray addObject:entity];
    }
    
    return [retArray copy];
}

@end
