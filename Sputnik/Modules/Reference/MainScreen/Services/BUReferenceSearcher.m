//
//  BUReferenceSearcher.m
//  SUAI_Navigation
//
//  Created by Виктор on 28/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceSearcher.h"
#import "BUFaculty.h"
#import "BUDepartment.h"
#import "BUFacultyDepartment.h"
#import "BUSubdivision.h"

@interface BUReferenceSearcher () {
    NSArray *references;
    NSMutableArray <BUInfoEntity *> *resultReference;
}

@end

@implementation BUReferenceSearcher

- (instancetype)initWithReference:(NSArray *)referenceInfo
{
    self = [super init];
    if (self) {
        references = referenceInfo;
        resultReference = [NSMutableArray array];
    }
    return self;
}

- (void)searchEntitiesWithSearchText:(NSString *)searchText {
    [resultReference removeAllObjects];
    for (NSArray *array in references) {
        for (BUInfoEntity *entity in array) {
            if ([entity isKindOfClass:[BUFaculty class]]) {
                BUFaculty *faculty = (BUFaculty *)entity;
                [self searchInFaculty:faculty withSearchText:searchText];
            }
            else if ([entity isKindOfClass:[BUDepartment class]]) {
                BUDepartment *department = (BUDepartment *)entity;
                [self searchInDepartment:department withSearchText:searchText];
            }
        }
    }
}

- (void)searchInFaculty:(BUFaculty *)faculty withSearchText:(NSString *)searchText {
    BOOL equalNames = [[[faculty name] lowercaseString] containsString:[searchText lowercaseString]];
    BOOL equalNumbers = [[[faculty number] lowercaseString] containsString:[searchText lowercaseString]];
    if (equalNames || equalNumbers) {
        [resultReference addObject:faculty];
    }
    
    for (BUFacultyDepartment *department in [faculty departments]) {
        equalNames = [[[department name] lowercaseString] containsString:[searchText lowercaseString]];
        equalNumbers = [[[department number] lowercaseString] containsString:[searchText lowercaseString]];
        if (equalNumbers || equalNames) {
            [resultReference addObject:department];
        }
    }
}

- (void)searchInDepartment:(BUDepartment *)department withSearchText:(NSString *)searchText {
    BOOL equalNames = [[[department name] lowercaseString] containsString:[searchText lowercaseString]];
    if (equalNames) {
        [resultReference addObject:department];
    }
    
    for (BUSubdivision *subdivision in [department subdivisions]) {
        equalNames = [[[subdivision name] lowercaseString] containsString:[searchText lowercaseString]];
        if (equalNames) {
            [resultReference addObject:subdivision];
        }
    }
}

- (void)didPressCellAtIndex:(NSUInteger)index {
    [self.delegate pushDetailInfoWithEntity:resultReference[index]];
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return [resultReference count];
}

- (NSString *)titleForCellAtRow:(NSUInteger)index inSection:(NSUInteger)section {
    return resultReference[index].name;
}

@end
