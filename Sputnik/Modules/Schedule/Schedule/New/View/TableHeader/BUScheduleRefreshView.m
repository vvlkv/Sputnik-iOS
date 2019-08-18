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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.text = @"";
    self.weekTypeLabel.text = @"";
}


#pragma mark - Setters

- (void)setDate:(NSString *)date {
    _date = date;
    [self.dateLabel setFont:[UIFont suaiRobotoFont:RobotoFontBold size:24.f]];
    self.dateLabel.text = date;
}

- (void)setWeek:(NSString *)week {
    _week = week;
    [self.weekTypeLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:15.f]];
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
