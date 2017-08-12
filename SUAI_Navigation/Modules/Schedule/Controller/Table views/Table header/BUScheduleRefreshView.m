//
//  BUScheduleHeaderView.m
//  SUAI_Navigation
//
//  Created by Виктор on 18.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleRefreshView.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BUScheduleRefreshView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekTypeLabel;

@end

@implementation BUScheduleRefreshView

- (void)setDate:(NSString *)date {
    _date = date;
    [self.dateLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:16.f]];
    self.dateLabel.text = date;
}

- (void)setWeek:(NSString *)week {
    _week = week;
    [self.weekTypeLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:16.f]];
    UIColor *contentColor;
    if ([_week containsString:@"нечетная"]) {
        contentColor = [UIColor suaiRedColor];
        
    } else {
        contentColor =  [UIColor suaiBlueColor];
    }
    self.weekTypeLabel.textColor = contentColor;
    self.weekTypeLabel.text = week;
}

@end
