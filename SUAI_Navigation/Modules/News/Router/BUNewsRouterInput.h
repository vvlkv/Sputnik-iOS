//
//  BUNewsRouterInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol BUNewsRouterInput <NSObject>

- (void)pushDetailNewsInfo:(NSString *)newsId
        fromViewController:(UIViewController *)viewController;

@end
