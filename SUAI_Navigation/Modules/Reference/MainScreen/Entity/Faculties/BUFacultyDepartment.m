//
//  BUDepartment.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUFacultyDepartment.h"
#import "BUHeader.h"
#import "BULink.h"

@implementation BUFacultyDepartment

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
    if ([key isEqualToString:@"_number"]) {
        _number = value;
    }
    if ([key isEqualToString:@"Header"]) {
        BUHeader *header = [[BUHeader alloc] init];
        for (NSString *key in [value allKeys]) {
            [header setkvcValue:[value valueForKey:key] forKey:key];
        }
        _header = header;
    }
    
    if ([key isEqualToString:@"Link"]) {
        BULink *link = [[BULink alloc] init];
        for (NSString *key in [value allKeys]) {
            [link setkvcValue:[value valueForKey:key] forKey:key];
        }
        _link = link;
    }
}

@end
