//
//  BUReferenceDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDataDisplayManager.h"
#import "BUFaculty.h"
#import "BUFacultyDepartment.h"
#import "BUDepartment.h"

@interface BUReferenceDataDisplayManager () {
    NSArray *pReference;
    NSUInteger activeIndex;
}

@property (readonly, nonatomic) NSArray *activeEntities;

@end


@implementation BUReferenceDataDisplayManager

- (instancetype)initWithReference:(NSArray *)reference
{
    self = [super init];
    if (self) {
        pReference = reference;
    }
    return self;
}

- (NSArray *)activeEntities {
    return pReference[activeIndex];
}

- (void)activeReference:(NSUInteger)activeReference {
    activeIndex = activeReference;
}



#pragma mark - BUReferenceMainScreenContentDataSource

- (NSUInteger)numberOfSections {
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return [[self activeEntities] count];
}

- (NSString *)titleForCellAtRow:(NSUInteger)index inSection:(NSUInteger)section {
    BUInfoEntity *entity = (BUInfoEntity *)[self activeEntities][index];
    return [entity name];
}


#pragma mark - BUReferenceMainScreenContentDelegate

- (void)didPressCellAtIndex:(NSUInteger)index {
    [self.delegate pushDetailInfoWithEntity:[self activeEntities][index]];
}

@end
