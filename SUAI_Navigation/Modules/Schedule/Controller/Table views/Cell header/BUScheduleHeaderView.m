//
//  BUScheduleHeaderView.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleHeaderView.h"
#import "UIFont+SUAI.h"

@interface BUScheduleHeaderView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *auditoryLabel;

@end

@implementation BUScheduleHeaderView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(16.0, 16.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
    CGFloat fontSize;
    if ([UIScreen mainScreen].bounds.size.width == 320.f) {
        fontSize = 17.f;
    } else {
        fontSize = 18.f;
    }
    self.timeLabel.font = [UIFont suaiRobotoFont:RobotoFontRegular size:fontSize];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.auditoryLabel.font = [UIFont suaiRobotoFont:RobotoFontRegular size:fontSize];
    self.auditoryLabel.textColor = [UIColor whiteColor];
}

- (void)setTime:(NSString *)time {
    _time = time;
    self.timeLabel.text = _time;
}

- (void)setAuditory:(NSString *)auditory {
    _auditory = auditory;
    self.auditoryLabel.text = _auditory;
}

@end
