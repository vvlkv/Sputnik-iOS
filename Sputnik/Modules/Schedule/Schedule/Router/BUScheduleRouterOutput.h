//
//  BUScheduleNewRouterOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 20/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleRouterOutput_h
#define BUScheduleRouterOutput_h

@class SUAIEntity;
@protocol BUScheduleRouterOutput <NSObject>
@required
- (void)didFindEntity:(SUAIEntity *)entity;

@end

#endif /* BUScheduleNewRouterOutput_h */
