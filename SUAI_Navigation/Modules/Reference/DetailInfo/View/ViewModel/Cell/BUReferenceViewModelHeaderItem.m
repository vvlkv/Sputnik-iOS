//
//  BUReferenceViewModelHeaderItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 20/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelHeaderItem.h"

@implementation BUReferenceViewModelHeaderItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _color = [UIColor blackColor];
    }
    return self;
}

- (ViewModelItem)ViewModelItemType {
    return ViewModelItemHeader;
}

- (BOOL)isSelectable {
    if ([self actionType] == ReferenceActionTypeAbout) {
        return YES;
    }
    return NO;
}

@end
