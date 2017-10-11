//
//  BUScheduleStorage.h
//  BUSUAIParser
//
//  Created by Виктор on 10.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Typedef.h"

@interface BUScheduleStorage : NSObject

- (void)deleteAllEntities;
- (NSArray *)loadScheduleFromDataBase;
- (void)writeScheduleToDataBase:(NSArray *)dataBase;

@end
