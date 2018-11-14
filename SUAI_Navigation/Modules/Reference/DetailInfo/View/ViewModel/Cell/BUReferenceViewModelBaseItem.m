//
//  BUReferenceViewModelAbstractItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 24/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelBaseItem.h"

@interface BUReferenceViewModelBaseItem () {
    ReferenceActionType actionType;
}

@end

@implementation BUReferenceViewModelBaseItem

- (instancetype)init
{
    return [self initWithAction:ReferenceActionTypeNone];
}

- (instancetype)initWithAction:(ReferenceActionType)type
{
    self = [super init];
    if (self) {
        actionType = type;
    }
    return self;
}

- (NSString *)value {
    return _value;
}

- (ViewModelItem)ViewModelItemType {
    return ViewModelItemHead;
}

- (ReferenceActionType)actionType {
    return actionType;
}

- (BOOL)isSelectable {
    return NO;
}

@end
