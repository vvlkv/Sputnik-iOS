//
//  BUFaculty.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUFaculty.h"
#import "BUDean.h"
#import "BUFacultyDepartment.h"

@interface BUFaculty () {
    NSMutableArray *departments;
}

@end

@implementation BUFaculty

- (instancetype)init
{
    self = [super init];
    if (self) {
        departments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
    if ([key isEqualToString:@"_number"]) {
        _number = value;
    }
    if ([key isEqualToString:@"_icon"]) {
        _icon = value;
    }
    if ([key isEqualToString:@"Dean"]) {
        BUDean *dean = [[BUDean alloc] init];
        for (NSString *key in [value allKeys]) {
            [dean setkvcValue:[value valueForKey:key] forKey:key];
        }
        _dean = dean;
    }
    if ([key isEqualToString:@"Department"]) {
        for (NSDictionary *department in [value allObjects]) {
            BUFacultyDepartment *departmentModel = [[BUFacultyDepartment alloc] init];
            for (NSString *key in [department allKeys]) {
                [departmentModel setkvcValue:[department valueForKey:key] forKey:key];
            }
            [departments addObject:departmentModel];
        }
    }
}

- (NSArray<BUFacultyDepartment *> *)departments {
    return [departments copy];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUFaculty *copyFaculty = [[[self class] alloc] init];
    copyFaculty.name = self.name;
    copyFaculty.number = self.number;
    copyFaculty.dean = [[self dean] copyWithZone:zone];
    return copyFaculty;
}

@end
