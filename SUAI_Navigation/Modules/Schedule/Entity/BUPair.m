//
//  BUPair.m
//  SUAI_Parser_New
//
//  Created by Виктор on 08.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUPair.h"

@implementation BUPair

- (instancetype)initWithPair:(NSString *)pairName
                 teacherName:(NSString *)teacherName
                    dayColor:(DayColor)dayColor
                  lessonType:(NSString *)lessonType
                     andTime:(NSString *)time
{
    self = [super init];
    if (self) {
        _name = pairName;
        _teacherName = teacherName;
        _color = dayColor;
        _lessonType = lessonType;
        _time = time;
    }
    return self;
}

@end
