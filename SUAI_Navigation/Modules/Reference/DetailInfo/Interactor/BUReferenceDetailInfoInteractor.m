//
//  BUReferenceDetailInfoInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoInteractor.h"
#import "BUReferenceEntityAssembler.h"
#import "BUFaculty.h"
#import "BUDepartment.h"
#import "BUDean.h"
#import "BUHeader.h"
#import "BUReferenceViewModelTable.h"

@interface BUReferenceDetailInfoInteractor () {
    id entity;
}

@end

@implementation BUReferenceDetailInfoInteractor

- (instancetype)initWithEntity:(id)e
{
    self = [super init];
    if (self) {
        entity = e;
    }
    return self;
}



- (void)modulesAssembled {
    BUReferenceEntityAssembler *entityAssembler = [[BUReferenceEntityAssembler alloc] init];
    [self.output didObtainDataViewModel:[entityAssembler assemblyDataFromEntity:entity]];
}


#pragma mark - BUReferenceDetailInfoInteractorInput

- (void)prepareDataToAboutInfo {
    if ([entity isMemberOfClass:[BUFaculty class]]) {
        BUFaculty *oldFaculty = (BUFaculty *)entity;
        BUFaculty *faculty = [oldFaculty copy];
        [self.output didPrepareDataToShow:faculty];
    }
    if ([entity isMemberOfClass:[BUDepartment class]]) {
        BUDepartment *oldDepartment = (BUDepartment *)entity;
        BUDepartment *department = [oldDepartment copy];
        [self.output didPrepareDataToShow:department];
    }
}

- (void)prepareEntityToShowDataAtIndex:(NSUInteger)index {
    if ([entity isMemberOfClass:[BUFaculty class]]) {
        BUFaculty *faculty = (BUFaculty *)entity;
        [self.output didPrepareDataToShow:[faculty departments][index]];
    }
    if ([entity isMemberOfClass:[BUDepartment class]]) {
        BUDepartment *department = (BUDepartment *)entity;
        [self.output didPrepareDataToShow:[department subdivisions][index]];
    }
}

@end
