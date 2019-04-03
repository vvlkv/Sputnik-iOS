//
//  BUSearchStorage.h
//  Sputnik
//
//  Created by Виктор on 03/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SUAIEntity;
@interface BUSearchStorage : NSObject

- (void)save:(SUAIEntity *)entity;
- (NSArray<SUAIEntity *> *)load;

@end

NS_ASSUME_NONNULL_END
