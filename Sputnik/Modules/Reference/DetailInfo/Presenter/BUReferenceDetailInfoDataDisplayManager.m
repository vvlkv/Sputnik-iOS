//
//  BUReferenceDetailInfoDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoDataDisplayManager.h"
#import "BUReferenceViewModelTableProtocol.h"
#import "BUDepartment.h"
#import "BUFaculty.h"
#import "BUFacultyDepartment.h"
#import "BUHeader.h"
#import "BUDean.h"

@interface BUReferenceDetailInfoDataDisplayManager () {
    id entity;
    NSArray *entities;
}

@end

@implementation BUReferenceDetailInfoDataDisplayManager

- (instancetype)initWithEntity:(id)e
{
    self = [super init];
    if (self) {
        entity = e;
    }
    return self;
}
- (instancetype)initWithEntities:(NSArray *)e;
{
    self = [super init];
    if (self) {
        entities = [NSArray arrayWithArray:e];
    }
    return self;
}

#pragma mark - BUReferenceTableViewDataSource

- (NSUInteger)rowsCountForTableViewModelType:(ViewModelTable)viewModelType {
    return [[self entityOfViewModelType:viewModelType] rowCount];
}

- (id <BUReferenceViewModelItemProtocol>)modelForTableViewModelType:(ViewModelTable)viewModelType
                                                     withRowAtIndex:(NSUInteger)index {
    return [[self entityOfViewModelType:viewModelType] modelForRow:index];
}

- (id <BUReferenceViewModelItemProtocol>)tableView:(UITableView *)tableView
                                   modelForSection:(NSUInteger)section
                                           atIndex:(NSUInteger)index {
    id <BUReferenceViewModelTableProtocol> entity = entities[section];
    return [entity modelForRow:index];
}

- (NSUInteger)numberOfSectionsInTableView:(id)tableView {
    return [entities count];
}


- (NSUInteger)tableView:(id)tableView numberOfRowsInSection:(NSUInteger)section {
    id <BUReferenceViewModelTableProtocol> entity = entities[section];
    return [entity rowCount];
}


- (id)cathedraAtIndex:(NSUInteger)index {
    BUFaculty *faculty = (BUFaculty *)entity;
    return [faculty departments][index - 1];
}

- (void)addViewModels:(NSArray *)e {
    entities = e;
}

- (id <BUReferenceViewModelTableProtocol>)entityOfViewModelType:(ViewModelTable)type {
    for (id entity in entities) {
        if ([entity conformsToProtocol:@protocol(BUReferenceViewModelTableProtocol)]) {
            if ([entity ViewModelTableType] == type)
                return entity;
        }
    }
    return nil;
}

- (BOOL)containsFaculties {
    if ([self entityOfViewModelType:ViewModelTableCathedras] == nil)
        return NO;
    return YES;
}

- (BOOL)containsSubDivisions {
    if ([self entityOfViewModelType:ViewModelTableSubDivisions] == nil)
        return NO;
    return YES;
}

@end
