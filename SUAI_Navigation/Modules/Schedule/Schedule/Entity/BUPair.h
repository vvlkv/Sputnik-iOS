//
//  BUPair.h
//  SUAI_Parser_New
//
//  Created by Виктор on 08.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DayColor {
    DayColorRed,
    DayColorBlue,
    DayColorBoth
} DayColor;

@interface BUPair : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *teacherName;
@property (strong, nonatomic) NSString *groups;
@property (assign, nonatomic) DayColor color;
@property (strong, nonatomic) NSString *lessonType;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *auditory;

- (instancetype)initWithPair:(NSString *)pairName
                 teacherName:(NSString *)teacherName
                    dayColor:(DayColor)dayColor
                  lessonType:(NSString *)lessonType
                     andTime:(NSString *)type;
@end
