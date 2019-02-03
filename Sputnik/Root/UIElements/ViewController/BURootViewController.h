//
//  BURootViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BURootViewController : UIViewController

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

- (void)showFailView:(NSString *)message action:(void(^)(void))action;
- (void)showInternetFailView;
- (void)hideInternetFailView;

@end
