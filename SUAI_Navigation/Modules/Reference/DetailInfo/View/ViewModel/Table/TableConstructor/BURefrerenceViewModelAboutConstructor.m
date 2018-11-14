//
//  BURefrerenceViewModelAboutConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURefrerenceViewModelAboutConstructor.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BUInfoEntity.h"

@implementation BURefrerenceViewModelAboutConstructor

#pragma mark - BUReferenceViewModelTableConstructorProtocol

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    NSString *entityName = [[(BUInfoEntity *)model name] lowercaseString];
    BUReferenceViewModelHeaderItem *aboutItem = [[BUReferenceViewModelHeaderItem alloc] initWithAction:ReferenceActionTypeAbout];
    if ([entityName containsString:@"институт"]) {
        aboutItem.value = @"Об институте";
    } else if ([entityName containsString:@"факультет"]) {
        aboutItem.value = @"О факультете";
    } else if ([entityName containsString:@"кафедра"]) {
        aboutItem.value = @"О кафедре";
    } else if ([entityName containsString:@"департамент"]) {
        aboutItem.value = @"О департаменте";
    } else {
        aboutItem.value = @"Ничегошеньки";
    }
    [rows addObject:aboutItem];
    return rows;
}

@end
