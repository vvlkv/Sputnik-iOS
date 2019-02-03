//
//  BUScheduleNewState.h
//  SUAI_Navigation
//
//  Created by Виктор on 26/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSUInteger, BUScheduleState) {
//    BUScheduleStateNone = 0,
//    BUScheduleStateEntitySelected = 1 << 0,
//    BUScheduleStateCodesAvailable = 1 << 1,
//    BUScheduleStateInternetReachable = 1 << 2,
//    BUScheduleStateScheduleAvailable = 1 << 3
//};

@interface BUScheduleState : NSObject

//@property (nonatomic, assign) BUScheduleState state;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSUInteger type;

- (instancetype)initWithEntity:(NSString *)name type:(NSUInteger)type;
- (void)setEntity:(NSString *)name type:(NSUInteger)type;

@end

NS_ASSUME_NONNULL_END
