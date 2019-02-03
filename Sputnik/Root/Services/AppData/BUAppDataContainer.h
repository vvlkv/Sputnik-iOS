//
//  BUAppDataContainer.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//
// Class that stores Application state in UserDefaults

#import <Foundation/Foundation.h>

@interface BUAppDataContainer : NSObject

@property (readonly, nonatomic) NSString *entity;
@property (readonly, nonatomic) NSUInteger type;
@property (readonly, nonatomic) NSUInteger startScreenIndex;
@property (nonatomic, readonly) NSUInteger weekType;

+ (instancetype)instance;

- (void)overwriteEntityWithName:(NSString *)name andType:(NSUInteger)type;
- (void)overwriteStartScreenIndex:(NSUInteger)index;
- (void)overwriteWeekType:(NSUInteger)weekType;

@end
