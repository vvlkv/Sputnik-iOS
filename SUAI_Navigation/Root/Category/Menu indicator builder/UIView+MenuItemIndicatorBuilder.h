//
//  UIView+MenuItemIndicatorBuilder.h
//  SUAI_Navigation
//
//  Created by Виктор on 02.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum WeekType {
    WeekTypeRed,
    WeekTypeBlue,
    WeekTypeBoth,
    WeekTypeNone
}WeekType;

@interface UIView (MenuItemIndicatorBuilder)

+ (UIView *)createIndicatorForWeekOfType:(WeekType)weekType;

@end
