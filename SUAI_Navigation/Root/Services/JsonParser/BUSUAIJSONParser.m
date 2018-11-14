//
//  BUSUAIParser.m
//  JSONParser
//
//  Created by Виктор on 17.10.2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUSUAIJSONParser.h"
#import "BUFaculty.h"
#import "BUDepartment.h"

@interface BUSUAIJSONParser () {
    NSData *jsonData;
}

@end


@implementation BUSUAIJSONParser

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        jsonData = data;
    }
    return self;
}

- (void)parseInformation {
    NSError *error;
    NSDictionary *objects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSDictionary *results = [objects valueForKey:@"informationsuai"];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setValue: [self parseFaculties:[results objectForKey:@"faculties"]] forKey:@"faculties"];
    [result setValue:[self parseDepartments:[results objectForKey:@"departments"]] forKey:@"departments"];
    [self.delegate didLoadInformation:result];
}

- (NSArray *)parseFaculties:(NSDictionary *)faculties {
    NSMutableArray *parsedFaculties = [[NSMutableArray alloc] init];
    NSArray *facultiesArray = [faculties objectForKey:@"facult"];
    for (NSDictionary *facult in facultiesArray) {
        BUFaculty *facultModel = [[BUFaculty alloc] init];
        for (NSString *key in [facult allKeys]) {
            [facultModel setkvcValue:[facult valueForKey:key] forKey:key];
        }
        [parsedFaculties addObject:facultModel];
    }
    return [parsedFaculties copy];
}

- (NSArray *)parseDepartments:(NSDictionary *)departments {
    NSMutableArray *parsedDepartments = [[NSMutableArray alloc] init];
    NSArray *departmentsArray = [departments objectForKey:@"Department"];
    for (NSDictionary *department in departmentsArray) {
        BUDepartment *departmentModel = [[BUDepartment alloc] init];
        for (NSString *key in [department allKeys]) {
            [departmentModel setkvcValue:[department valueForKey:key] forKey:key];
        }
        [parsedDepartments addObject:departmentModel];
    }
    return [parsedDepartments copy];
}


@end
