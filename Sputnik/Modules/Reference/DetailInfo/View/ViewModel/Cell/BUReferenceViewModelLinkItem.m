//
//  BUReferenceViewModelLinkItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelLinkItem.h"

@implementation BUReferenceViewModelLinkItem

- (ViewModelItem)ViewModelItemType {
    return ViewModelItemLink;
}

- (BOOL)isSelectable {
    return YES;
}

@end
