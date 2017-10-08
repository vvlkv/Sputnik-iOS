//
//  BUCalendarWireFrame.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@interface BUCalendarWireFrame : NSObject

+ (UIViewController *)assemblyCalendarWithData:(NSArray *)data;
+ (UIViewController *)assemblyCalendarWithData:(NSArray *)data andRootViewController:(UIViewController *)viewController;

@end
