//
//  SUAIPageViewController.h
//  PageViewControllerTest
//
//  Created by Виктор on 15/12/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUAIPageViewController : UIViewController

- (instancetype)initWithViewControllers:(NSArray <__kindof UIViewController *> *)viewControllers;

- (instancetype)initWithViewControllers:(NSArray <__kindof UIViewController *> *)viewControllers
                         activeAtIndex:(NSUInteger)index;

- (void)updateMarkers:(NSArray *)markers;

@end

NS_ASSUME_NONNULL_END
