//
//  BUItem.h
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractItem.h"

typedef enum ItemType {
    ItemTypeOther,
    ItemTypeDepartment
}ItemType;

@interface BUItem : BUAbstractItem

@property (assign, nonatomic) ItemType type;
@property (strong, nonatomic) NSString *time;
@property (readonly, nonatomic) NSMutableArray *infoFields;

- (instancetype)initWithType:(ItemType)type;

@end
