//
//  BUReferenceEntityAssembler.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceEntityAssembler.h"
#import "BUFaculty.h"
#import "BUFacultyDepartment.h"
#import "BUDean.h"
#import "BUHeader.h"
#import "BUDepartment.h"
#import "BUSubdivision.h"
#import "BUReferenceViewModelTable.h"

@implementation BUReferenceEntityAssembler

- (NSArray *)assemblyDataFromEntity:(id)entity {
    NSMutableArray *entities = [NSMutableArray arrayWithArray:[self assemblyHead:entity]];
    if ([entity isMemberOfClass:[BUFaculty class]]) {
        [entities addObjectsFromArray:[self assemblyFaculty:(BUFaculty *)entity]];
    } else if ([entity isMemberOfClass:[BUFacultyDepartment class]]) {
        [entities addObjectsFromArray:[self assemblyFacultyDepartmensInfo:(BUFacultyDepartment *)entity]];
    } else if ([entity isMemberOfClass:[BUDepartment class]]) {
        [entities addObjectsFromArray:[self assemblyDepartments:(BUDepartment *)entity]];
    } else if ([entity isMemberOfClass:[BUSubdivision class]]) {
        [entities addObjectsFromArray:[self assemblySubDivision:(BUSubdivision *)entity]];
    }
    return entities;
}

- (NSArray *)assemblyHead:(BUInfoEntity *)infoEntity {
    BUReferenceViewModelTable *headTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableHead];
    [headTable addModel:infoEntity];
    return @[headTable];
}

- (NSArray *)assemblyFaculty:(BUFaculty *)faculty {
    NSMutableArray *entities = [NSMutableArray array];
    if ([[faculty departments] count] > 0) {
        [entities addObjectsFromArray:[self assemblyFacultyDepartments:faculty]];
    } else {
        [entities addObjectsFromArray:[self assemblyAbout:[faculty dean]]];
        
    }
    return [entities copy];
}

- (NSArray *)assemblyFacultyDepartments:(BUFaculty *)faculty {
    NSMutableArray *entities = [NSMutableArray array];
    BUReferenceViewModelTable *cathedralTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableCathedras];
    [cathedralTable addModel:faculty];
    [entities addObject:cathedralTable];
    BUReferenceViewModelTable *aboutTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableAbout];
    [aboutTable addModel:faculty];
    [entities addObject:aboutTable];
    return [entities copy];
}

- (NSArray *)assemblyAbout:(BUDean *)dean {
    NSMutableArray *entities = [NSMutableArray array];
    BUReferenceViewModelTable *directorTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableDirector];
    [directorTable addModel:[dean header]];
    [entities addObject:directorTable];
    if ([[dean subHeaders] count] > 0) {
        BUReferenceViewModelTable *subHeadersTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableSubHeaders];
        [subHeadersTable addModel:[dean subHeaders]];
        [entities addObject:subHeadersTable];
    }
    
    BUReferenceViewModelTable *linkTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableLink];
    [linkTable addModel:[dean link]];
    [entities addObject:linkTable];
    return [entities copy];
}

- (NSArray *)assemblyDepartments:(BUDepartment *)department {
    NSMutableArray *entities = [NSMutableArray array];
    if ([[department subdivisions] count] > 0) {
        BUReferenceViewModelTable *subDivisionsTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableSubDivisions];
        [subDivisionsTable addModel:[department subdivisions]];
        [entities addObject:subDivisionsTable];
        BUReferenceViewModelTable *aboutTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableAbout];
        [aboutTable addModel:department];
        [entities addObject:aboutTable];
    } else {
        return [self assemblyAboutDepartment:department];
    }
    
    return entities;
}

- (NSArray *)assemblyFacultyDepartmensInfo:(BUFacultyDepartment *)facultyDepartment {
    NSMutableArray *entities = [NSMutableArray array];
    BUReferenceViewModelTable *directorTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableDirector];
    [directorTable addModel:[facultyDepartment header]];
    [entities addObject:directorTable];
    BUReferenceViewModelTable *linkTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableLink];
    [linkTable addModel:[facultyDepartment link]];
    [entities addObject:linkTable];
    return entities;
}

- (NSArray *)assemblySubDivision:(BUSubdivision *)subdivision {
    NSMutableArray *entities = [NSMutableArray array];
    
    BUReferenceViewModelTable *directorTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableDirector];
    [directorTable addModel:[subdivision header]];
    [entities addObject:directorTable];
    
    BUReferenceViewModelTable *timeTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableTime];
    [timeTable addModel:[subdivision time]];
    if ([timeTable rowCount] > 0)
        [entities addObject:timeTable];
    
    BUReferenceViewModelTable *linkTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableLink];
    [linkTable addModel:subdivision];
    [entities addObject:linkTable];
    return entities;
}

- (NSArray *)assemblyAboutDepartment:(BUDepartment *)department {
    NSMutableArray *entities = [NSMutableArray array];
    BUReferenceViewModelTable *directorTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableDirector];
    [directorTable addModel:[department header]];
    [entities addObject:directorTable];
    
    BUReferenceViewModelTable *linkTable = [[BUReferenceViewModelTable alloc] initWithType:ViewModelTableLink];
    [linkTable addModel:department];
    
    [entities addObject:linkTable];
    return entities;
}

- (void)validate:(NSArray <BUReferenceViewModelTableProtocol> *)entities {
}

@end
