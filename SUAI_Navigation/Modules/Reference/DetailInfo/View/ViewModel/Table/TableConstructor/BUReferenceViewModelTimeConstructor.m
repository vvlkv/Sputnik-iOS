//
//  BUReferenceViewModelTimeConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelTimeConstructor.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BUReferenceViewModelTimeItem.h"
#import "BUTime.h"

@implementation BUReferenceViewModelTimeConstructor

- (NSArray *)createModelFrom:(id)model {
    
    NSMutableArray *entities = [NSMutableArray array];
    NSArray *times = (NSArray *)model;
    if ([times count] == 0)
        return entities;
    BUReferenceViewModelHeaderItem *head = [[BUReferenceViewModelHeaderItem alloc] init];
    head.value = @"Приемные часы";
    head.color = [UIColor grayColor];
    [entities addObject:head];
    
    for (BUTime *time in times) {
        BUReferenceViewModelTimeItem *timeItem = [[BUReferenceViewModelTimeItem alloc] initWithAction:ReferenceActionTypeNone];
        timeItem.value = [time time];
        timeItem.nameDescription = [time day];
        [entities addObject:timeItem];
    }
    
    return entities;
}

@end
