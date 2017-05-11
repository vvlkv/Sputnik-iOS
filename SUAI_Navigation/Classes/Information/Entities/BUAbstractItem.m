//
//  BUAbstractItem.m
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractItem.h"

@interface BUAbstractItem() {
    
}

@end

@implementation BUAbstractItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageIcons = [NSMutableArray arrayWithObjects:@"Usr icon", @"Clock icon", @"Phone icon", @"Position icon", nil];
    }
    return self;
}

- (void)setName:(NSString *)name {
    [super setName:name];
}

- (void)setAuditorium:(NSString *)auditorium {
    _auditorium = auditorium;
    if ([_auditorium isEqualToString:@"N/A"]) {
        [self.imageIcons removeObject:@"Position icon"];
    }
}

- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    if ([_telephone isEqualToString:@"N/A"]) {
        [self.imageIcons removeObject:@"Phone icon"];
    }
}

- (NSMutableArray *)infoFields {
    NSArray *properties = @[self.name, self.telephone, self.auditorium];
    NSMutableArray *activeObjects = [NSMutableArray array];
    for (NSString *value in properties) {
        if (![value isEqualToString:@"N/A"]) {
            [activeObjects addObject:value];
        }
    }
    return activeObjects;
}

@end
