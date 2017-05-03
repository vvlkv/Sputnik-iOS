//
//  BUFaculty.m
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUFaculty.h"

@implementation BUFaculty

- (instancetype)initWithNumber:(NSString *)number
                       andName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.departments = [NSMutableArray array];
        self.name = name;
        self.number = number;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.number = [decoder decodeObjectForKey:@"number"];
        self.departments = [decoder decodeObjectForKey:@"departments"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_number forKey:@"number"];
    [aCoder encodeObject:_departments forKey:@"departments"];
}

- (NSString *)definition {
    NSRange range = [_name rangeOfString:@" " options:NSCaseInsensitiveSearch];
    NSMutableString *viewString = [NSMutableString stringWithString:_name];
    NSString *number = [NSString stringWithFormat:@" (№%@)", _number];
    [viewString insertString:number atIndex:range.location];
    return [NSString stringWithString:viewString];
}

@end
