//
//  BUItem.h
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDean.h"

typedef enum Type {
    ItemTypeDepartment,
    ItemTypeOther,
    ItemTypeDean
} ItemType;

@interface BUItem : BUDean

@property (assign, nonatomic) ItemType type;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *time;

- (instancetype)initWithType:(ItemType)type;

- (NSString *)shortName;

@end
