//
//  BUScheduleRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol BUScheduleRouterInput <NSObject>

@required
- (void)presentSearchViewControllerWithItems:(NSArray *)items
                          fromViewController:(UIViewController *)viewController
                                andPresenter:(id)presenter;
- (void)pushDetailViewControllerFromViewController:(UIViewController *)viewController
                                        withEntity:(NSString *)entity
                                           andType:(NSUInteger)type;

- (void)passAuditory:(NSString *)auditory fromNavigationViewController:(UIViewController *)viewController;

@end
