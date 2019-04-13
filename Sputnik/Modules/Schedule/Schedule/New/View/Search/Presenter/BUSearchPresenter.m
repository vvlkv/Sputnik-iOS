//
//  BUSearchPresenter.m
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSearchPresenter.h"
#import "SUAI.h"
#import "SUAIEntity.h"
#import "BUSearchResultsViewModel.h"
#import "BUScheduleSearchViewControllerInput.h"

#import "BUSearchStorage.h"

@interface BUSearchPresenter() {
    BUSearchStorage *storage;
    NSArray<SUAIEntity *> *groups;
    NSArray<SUAIEntity *> *teachers;
    NSArray<SUAIEntity *> *auditories;
    NSMutableArray<BUSearchResultsViewModel *> *searchResults;
}

@end

@implementation BUSearchPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        storage = [[BUSearchStorage alloc] init];
        groups = [[[SUAI instance] schedule] groups];
        teachers = [[[SUAI instance] schedule] teachers];
        auditories = [[[SUAI instance] schedule] auditories];
        searchResults = [NSMutableArray array];
        [self p_fullFillSearchResults];
    }
    return self;
}

- (void)p_fullFillSearchResults {
    var *lastSearchEntities = [storage load];
    if ([lastSearchEntities count] > 0)
        [searchResults addObject:[[BUSearchResultsViewModel alloc] initWithName:@"Вы искали" andEntities:lastSearchEntities]];
    [searchResults addObject:[[BUSearchResultsViewModel alloc] initWithName:@"Группы" andEntities:groups]];
    [searchResults addObject:[[BUSearchResultsViewModel alloc] initWithName:@"Преподаватели" andEntities:teachers]];
    [searchResults addObject:[[BUSearchResultsViewModel alloc] initWithName:@"Аудитории" andEntities:auditories]];
}

#pragma mark - BUScheduleSearchViewControllerOutput

- (void)didChangeSearchContent:(NSString *)searchString {
    [searchResults removeAllObjects];
    NSMutableString *str = [[NSMutableString alloc] initWithString:searchString];
    if ([str length] > 0)
        [str appendString:@"*"];
    if ([str length] > 3)
        [str insertString:@"*" atIndex:2];
    var *predicate = [NSPredicate predicateWithFormat:@"SELF.name like %@", str];
    var *groupsSearchRes = [self searchInEntities:groups ofName:@"Группы" withPredicate:predicate];
    if (groupsSearchRes != nil)
        [searchResults addObject:groupsSearchRes];
    var *teachersSearchRes = [self searchInEntities:teachers ofName:@"Преподаватели" withPredicate:predicate];
    if (teachersSearchRes != nil)
        [searchResults addObject:teachersSearchRes];
    var *audSearchRes = [self searchInEntities:auditories ofName:@"Аудитории" withPredicate:predicate];
    if (audSearchRes != nil)
        [searchResults addObject:audSearchRes];
    if ([searchResults count] == 0) {
        if ([searchString isEqualToString:@""]) {
            //nothing -> fullfill
            [self p_fullFillSearchResults];
        } else {
            //TODO show something like "nothing"
            
        }
    }
    [self.view reloadData];
}

- (void)didSelectRowAtSection:(NSUInteger)section row:(NSUInteger)row {
    var entity = [searchResults[section] entities][row];
    [storage save:entity];
    self.didFindEntity(entity);
}

- (NSUInteger)numberOfSections {
    return [searchResults count];
}
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return [[searchResults[section] entities] count];
}
- (NSString *)titleForHeaderInSection:(NSUInteger)section {
    return [searchResults[section] name];
}

- (NSString *)textForRowInSection:(NSUInteger)section atRow:(NSUInteger)row {
    return [[searchResults[section] entities][row] name];
}

- (BUSearchResultsViewModel *)searchInEntities:(NSArray <SUAIEntity *> *)entities
                                      ofName:(NSString *)name
                               withPredicate:(NSPredicate *)predicate {
    var *searchResults = [entities filteredArrayUsingPredicate:predicate];
    BUSearchResultsViewModel *results = nil;
    if ([searchResults count] > 0)
        results = [[BUSearchResultsViewModel alloc] initWithName:name andEntities:searchResults];
    return results;
}

@end
