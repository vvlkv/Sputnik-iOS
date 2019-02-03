//
//  BUSettingsRouterOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAIEntity;
@protocol BUSettingsRouterOutput <NSObject>
@required
- (void)didFindEntity:(SUAIEntity *)entity;

@end
