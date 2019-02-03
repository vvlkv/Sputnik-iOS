//
//  BUGreetingsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAIEntity;
@protocol BUGreetingsInteractorOutput <NSObject>

@required
- (void)didObtainGroupCodes:(NSArray <SUAIEntity *> *)groupCodes teacherCodes:(NSArray <SUAIEntity *> *)teacherCodes;
//- (void)didObtainCodes:(NSDictionary *)codes;
- (void)didFailConnection;
- (void)didInternetBecomeReachable;

@end
