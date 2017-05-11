//
//  BUAuditoriesModel.m
//  SUAI_Navigation
//
//  Created by Виктор on 28.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAuditoriesModel.h"
#import "BUSUAIInfoParser.h"
#import "BUFaculty.h"
#import "BUItem.h"

@interface BUAuditoriesModel()<NSXMLParserDelegate> {
    NSArray *pObjects;
    NSUInteger pActualScope;
    BUSUAIInfoParser *parser;
}

@property (readonly, nonatomic) NSArray *actualObjects;

@end

@implementation BUAuditoriesModel


#pragma mark - Root

- (instancetype)init
{
    self = [super init];
    if (self) {
        parser = [[BUSUAIInfoParser alloc] init];
        pActualScope = 0;
    }
    return self;
}

- (void)prepareInformationData {
    pObjects = [parser loadFile];
}


#pragma mark - Updates

- (void)updateScope:(NSUInteger)scope {
    pActualScope = scope;
}

- (NSUInteger)selectedScope {
    return pActualScope;
}

#pragma mark - DataAccess

- (NSUInteger)itemsCountForSection:(NSUInteger)section {
    
    if ([[self.actualObjects firstObject] isKindOfClass:[BUFaculty class]]) {
        BUFaculty *faculty = (BUFaculty *)self.actualObjects[section];
        return [[faculty allObjects] count];
    }
    return [self.actualObjects count];
}

- (NSUInteger)sectionsCountAtIndex:(NSUInteger)index {
    NSUInteger totalObjects = [[self actualObjects] count];
    if ([[[self actualObjects] firstObject] isKindOfClass:[BUFaculty class]] || totalObjects == 0)
        return totalObjects;
    return 1;
}

- (NSString *)titleAtIndex:(NSUInteger)index
                 inSection:(NSUInteger)section {
    
    if ([self.actualObjects[section] isKindOfClass:[BUFaculty class]]) {
        BUFaculty *faculty = (BUFaculty *)self.actualObjects[section];
        BUItem *item = ((BUItem *)[faculty allObjects][index]);
        return [item title];
    }
    return [self.actualObjects[index] title];
}

- (NSString *)headerAtIndex:(NSUInteger)index {
    if ([self.actualObjects[index] isKindOfClass:[BUFaculty class]] && [self.actualObjects count] > 0) {
        return [((BUFaculty *)self.actualObjects[index]) title];
    }
    return @"";
}

- (BUDean *)entityAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    if ([self.actualObjects[section] isKindOfClass:[BUFaculty class]]) {
        BUFaculty *faculty = (BUFaculty *)self.actualObjects[section];
        return [faculty allObjects][index];
    }
    return self.actualObjects[index];
}

- (BOOL)isSelectableAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    if ([self.actualObjects[section] isKindOfClass:[BUFaculty class]]) {
        return YES;
    }
    return ([[self.actualObjects[index] infoFields] count] > 1) ? YES : NO;
}

- (NSString *)auditoryAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    if ([self.actualObjects[section] isKindOfClass:[BUFaculty class]]) {
        BUFaculty *faculty = (BUFaculty *)self.actualObjects[section];
        return [((BUAbstractItem *)[faculty allObjects][index]) auditorium];
    }
    return [((BUAbstractItem *)self.actualObjects[index]) auditorium];
}

#pragma mark - Getters

- (NSArray *)actualObjects {
    return pObjects[pActualScope];
}

@end
