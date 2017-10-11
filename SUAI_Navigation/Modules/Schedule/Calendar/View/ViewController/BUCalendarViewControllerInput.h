//
//  BUCalendarViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 14.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUCalendarViewControllerInput <NSObject>

@required
- (void)reloadView;
- (void)setDayIndex:(NSUInteger)index;
- (void)addAlertViewWithItems:(NSArray *)items;
- (void)dismiss;

@end
