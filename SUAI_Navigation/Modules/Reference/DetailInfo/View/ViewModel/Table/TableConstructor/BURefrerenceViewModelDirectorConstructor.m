//
//  BURefrerenceViewModelDirectorConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURefrerenceViewModelDirectorConstructor.h"
#import "BUHeader.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BUReferenceViewModelDefaultItem.h"

@implementation BURefrerenceViewModelDirectorConstructor

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    BUHeader *director = (BUHeader *)model;
    if (![[director type] isEqualToString:@""]) {
        BUReferenceViewModelHeaderItem *headItem = [[BUReferenceViewModelHeaderItem alloc] init];
        headItem.value = [director type];
        headItem.color = [UIColor grayColor];
        [rows addObject:headItem];
    }
    if (![[director name] isEqualToString:@""]) {
        BUReferenceViewModelDefaultItem *nameItem = [[BUReferenceViewModelDefaultItem alloc] init];
        nameItem.value = [director name];
        nameItem.canSelect = NO;
        [rows addObject:nameItem];
    }
    if (![[director phone] isEqualToString:@""]) {
        BUReferenceViewModelDefaultItem *phoneItem = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeCall];
        phoneItem.value = [director phone];
        [rows addObject:phoneItem];
    }
    if (![[director mail] isEqualToString:@""]) {
        BUReferenceViewModelDefaultItem *mailItem = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeMail];
        mailItem.value = [director mail];
        [rows addObject:mailItem];
    }
    if (![[director pos] isEqualToString:@""]) {
        BUReferenceViewModelDefaultItem *posItem = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeAuditory];
        posItem.value = [NSString stringWithFormat:@"%@ %@", director.pos, director.aud];
        [rows addObject:posItem];
    }
    return rows;
}

@end
