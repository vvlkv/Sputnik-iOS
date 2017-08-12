//
//  BUSettingsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSettingsInteractorOutput <NSObject>

- (void)didObtainCodes:(NSDictionary *)codes;
- (void)didObtainEntityName:(NSString *)name;
- (void)didObtainEntityType:(NSUInteger)type;
- (void)didObtainStartScreenIndex:(NSUInteger)index;

@end
