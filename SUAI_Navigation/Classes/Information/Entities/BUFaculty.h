//
//  BUFaculty.h
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAbstractEntity.h"

@class BUDean;
@interface BUFaculty : BUAbstractEntity

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) BUDean *dean;
@property (readonly, nonatomic) NSArray *cathedrals;
@property (readonly, nonatomic) NSArray *allObjects;

- (instancetype)initWithNumber:(NSString *)number
                       andName:(NSString *)name;

- (void)addCathedral:(id)cathedral;

@end
