//
//  BUReferenceViewModelDefaultItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelDefaultItem.h"

@implementation BUReferenceViewModelDefaultItem

- (instancetype)initWithAction:(ReferenceActionType)type {
    self = [super initWithAction:type];
    if (self) {
        _color = [UIColor blackColor];
        _canSelect = YES;
    }
    return self;
}

- (ViewModelItem)ViewModelItemType {
    return ViewModelItemDefault;
}

- (BOOL)isSelectable {
    return _canSelect;
}

@end
