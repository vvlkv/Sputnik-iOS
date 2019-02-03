//
//  BUReferenceMainScreenRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 13/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol BUReferenceMainScreenRouterInput <NSObject>

@required
- (void)presentDetailInfoViewControllerWithEntity:(id)entity fromViewController:(UIViewController *)viewController;
- (void)viewController:(UIViewController *)viewController
         foundAuditory:(NSString *)auditory;
@end
