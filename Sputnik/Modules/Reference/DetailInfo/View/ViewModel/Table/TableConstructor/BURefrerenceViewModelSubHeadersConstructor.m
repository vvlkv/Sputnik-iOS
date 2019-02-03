//
//  BURefrerenceViewModelSubHeadersConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURefrerenceViewModelSubHeadersConstructor.h"
#import "BUReferenceViewModelDefaultItem.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "BUHeader.h"

@implementation BURefrerenceViewModelSubHeadersConstructor

- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    NSArray *subHeaders = (NSArray *)model;
    BUReferenceViewModelHeaderItem *head = [[BUReferenceViewModelHeaderItem alloc] init];
    head.value = @"Заместители";
    head.color = [UIColor grayColor];
    [rows addObject:head];
    for (BUHeader *subHeader in subHeaders) {
        BUReferenceViewModelDefaultItem *type = [[BUReferenceViewModelDefaultItem alloc] init];
        type.value = [subHeader type];
        type.color = [UIColor grayColor];
        type.canSelect = NO;
        [rows addObject:type];
        if (![[subHeader name] isEqualToString:@""]) {
            BUReferenceViewModelDefaultItem *name = [[BUReferenceViewModelDefaultItem alloc] init];
            name.value = [subHeader name];
            name.canSelect = NO;
            [rows addObject:name];
        }
        if (![[subHeader phone] isEqualToString:@""]) {
            BUReferenceViewModelDefaultItem *phone = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeCall];
            phone.value = [subHeader phone];
            [rows addObject:phone];
        }
        if (![[subHeader pos] isEqualToString:@""]) {
            BUReferenceViewModelDefaultItem *aud = [[BUReferenceViewModelDefaultItem alloc] initWithAction:ReferenceActionTypeAuditory];
            aud.value = [NSString stringWithFormat:@"%@ %@", [subHeader pos], [subHeader aud]];
            [rows addObject:aud];
        }
    }
    return rows;
}

@end
