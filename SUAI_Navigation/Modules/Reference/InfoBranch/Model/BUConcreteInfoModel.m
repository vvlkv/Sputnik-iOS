//
//  BUConcreteInfoModel.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUConcreteInfoModel.h"
#import "BUAbstractItem.h"
#import "BUAbstractFacultyItem.h"

@interface BUConcreteInfoModel() {
    BUAbstractFacultyItem *item;
    NSString *header;
}

@end

@implementation BUConcreteInfoModel

- (instancetype)initWithData:(id)data
{
    self = [super init];
    if (self) {
        item = data;
    }
    return self;
}

- (NSUInteger)itemsCount {
    return [[item infoFields] count];
}

- (NSString *)titleAtIndex:(NSUInteger)index {
    return [item infoFields][index];
}

- (NSString *)tableHeader {
    if ([item isKindOfClass:[BUAbstractFacultyItem class]]) {
        return [item parentName];
    }
    return [item title];
}

- (NSUInteger)cellTypeAtIndex:(NSUInteger)index {
    if ([item isKindOfClass:[BUAbstractFacultyItem class]] && index == 0) {
        return 0;
    }
    return 1;
}

- (NSString *)cellDescription {
    return ((BUAbstractFacultyItem *)item).nameDescription;
}

- (NSString *)imageNameAtIndex:(NSUInteger)index {
    return [item imageIcons][index];
}

- (BOOL)isSelectableAtIndex:(NSUInteger)index {
    NSArray *selectableFields = @[@"Phone icon", @"Position icon"];
    if ([selectableFields containsObject:[item imageIcons][index]]) {
        return YES;
    }
    return NO;
}

- (NSString *)auditory {
    return [item auditorium];
}

@end
