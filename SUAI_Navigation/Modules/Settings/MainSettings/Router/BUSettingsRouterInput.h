//
//  BUSettingsRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol BUSettingsRouterInput <NSObject>

@required
- (void)presentSearchViewControllerWithItems:(NSArray *)items fromViewController:(UIViewController *)viewController
                                         andPresenter:(id)presenter;

- (void)pushAboutAppViewControllerFromViewController:(UIViewController *)viewController;

@end
