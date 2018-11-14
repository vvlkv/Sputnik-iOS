//
//  BUReferenceViewModelCathedraConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelCathedraConstructor.h"
#import "BUFaculty.h"
#import "BUFacultyDepartment.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BURefrerenceViewModelCathedralItem.h"

@implementation BUReferenceViewModelCathedraConstructor

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    BUFaculty *faculty = (BUFaculty *)model;
    BUReferenceViewModelHeaderItem *head = [[BUReferenceViewModelHeaderItem alloc] init];
    head.value = @"Кафедры";
    head.color = [UIColor grayColor];
    [rows addObject:head];
    for (BUFacultyDepartment *cathedral in [faculty departments]) {
        BURefrerenceViewModelCathedralItem *cathedralItem = [[BURefrerenceViewModelCathedralItem alloc] init];
        cathedralItem.number = [NSString stringWithFormat:@"Кафедра %@", [cathedral number]];
        cathedralItem.value = [cathedral name];
        [rows addObject:cathedralItem];
    }
    return rows;
}

@end
