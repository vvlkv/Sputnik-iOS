//
//  BUReferenceViewModelItemProtocol.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+SUAI.h"

typedef enum ViewModelItem {
    ViewModelItemHead,
    ViewModelItemHeader,
    ViewModelItemCathedral,
    ViewModelItemDefault,
    ViewModelItemLink,
    ViewModelItemTime
} ViewModelItem;

typedef enum ReferenceActionType {
    ReferenceActionTypeCall,
    ReferenceActionTypeAuditory,
    ReferenceActionTypeMail,
    ReferenceActionTypeSite,
    ReferenceActionTypeAbout,
    ReferenceActionTypeNone,
    ReferenceActionTypeEntity
} ReferenceActionType;

@protocol BUReferenceViewModelItemProtocol <NSObject>
@required
- (NSString *)value;
- (ViewModelItem)ViewModelItemType;
- (ReferenceActionType)actionType;
- (BOOL)isSelectable;

@end
