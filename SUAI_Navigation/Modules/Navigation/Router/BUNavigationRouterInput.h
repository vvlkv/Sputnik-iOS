//
//  BUNavigationRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol BUNavigationRouterInput <NSObject>

@required
- (void)presentSearchViewControllerFromViewController:(UIViewController *)viewController andPresenter:(id)presenter;
- (void)presentCameraViewControllerFromViewController:(UIViewController *)viewController andPresenter:(id)presenter;

@end
