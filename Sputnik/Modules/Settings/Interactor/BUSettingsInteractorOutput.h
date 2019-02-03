//
//  BUSettingsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAIEntity;
@protocol BUSettingsInteractorOutput <NSObject>

- (void)didObtainCodesGroups:(NSArray <SUAIEntity *> *)groups andTeachers:(NSArray <SUAIEntity *> *)teachers;
- (void)didObtainEntityName:(NSString *)name;
- (void)didObtainEntityType:(NSUInteger)type;
- (void)didObtainStartScreenIndex:(NSUInteger)index;

@end
