//
//  BURefrerenceViewModelCathedralItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURefrerenceViewModelCathedralItem.h"

@implementation BURefrerenceViewModelCathedralItem

- (ViewModelItem)ViewModelItemType {
    return ViewModelItemCathedral;
}

- (ReferenceActionType)actionType {
    return ReferenceActionTypeEntity;
}
- (BOOL)isSelectable {
    return YES;
}

@end
