//
//  BUCalendar.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUCalendar.h"

#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

#import "NSCalendar+CurrentDay.h"

@interface BUCalendar ()

@end

@implementation BUCalendar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locale = [NSLocale localeWithLocaleIdentifier:@"ru-RU"];
        self.firstWeekday = 2;
        self.scope = FSCalendarScopeMonth;
        self.appearance.titleFont = [UIFont suaiRobotoFont:RobotoFontMedium size:17.f];
        self.appearance.weekdayFont = [UIFont suaiRobotoFont:RobotoFontMedium size:14.f];
        self.appearance.weekdayTextColor = [UIColor blackColor];
        self.appearance.headerTitleFont = [UIFont suaiRobotoFont:RobotoFontBold size:18.f];
        self.appearance.headerTitleColor = [UIColor blackColor];
        self.appearance.selectionColor = [UIColor suaiPurpleColor];
        self.appearance.titleTodayColor = [UIColor whiteColor];
        self.appearance.todayColor = [UIColor suaiLightPurpleColor];
    }
    return self;
}

@end
