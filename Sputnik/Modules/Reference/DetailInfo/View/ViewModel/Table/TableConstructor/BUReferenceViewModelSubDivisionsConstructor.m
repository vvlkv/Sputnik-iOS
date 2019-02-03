//
//  BUReferenceViewModelSubDivisionsConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 23/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelSubDivisionsConstructor.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BUReferenceViewModelDefaultItem.h"
#import "BUSubdivision.h"

@implementation BUReferenceViewModelSubDivisionsConstructor

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    NSArray *subDivisions = (NSArray *)model;
    BUReferenceViewModelHeaderItem *head = [[BUReferenceViewModelHeaderItem alloc] init];
    head.value = @"Подразделения";
    head.color = [UIColor grayColor];
    [rows addObject:head];
    for (BUSubdivision *subDivision in subDivisions) {
        BUReferenceViewModelDefaultItem *type = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeEntity];
        type.value = [subDivision name];
        type.canSelect = YES;
        [rows addObject:type];
    }
    return rows;
}

@end
