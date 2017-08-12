//
//  BUSettingsPresenterState.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUSettingsPresenterState : NSObject

@property (strong, nonatomic) NSDictionary *codes;
@property (strong, nonatomic) NSString *entityName;
@property (assign, nonatomic) NSUInteger entityType;
@property (assign, nonatomic) NSUInteger startScreenIndex;

@end
