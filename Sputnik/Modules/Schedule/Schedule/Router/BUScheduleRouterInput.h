//
//  BUScheduleNewRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 20/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleRouterInput_h
#define BUScheduleRouterInput_h

@class UIViewController;
@class SUAISchedule;

@protocol BUScheduleRouterInput <NSObject>
@required
- (void)pushScheduleViewControllerFromViewController:(__kindof UIViewController *)vc
                                          withEntity:(NSString *)entity
                                                type:(NSUInteger)type;

- (void)presentCalendarViewControllerFromViewController:(__kindof UIViewController *)vc withSchedule:(SUAISchedule *)schedule;
- (void)presentSearchViewControllerFromViewController:(__kindof UIViewController *)vc;

- (void)showAuditory:(NSString *)auditory fromViewController:(__kindof UIViewController *)vc;

@end

#endif /* BUScheduleRouterInput_h */
