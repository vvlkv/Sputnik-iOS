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

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(16.0, 16.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
    self.timeLabel.font = [UIFont suaiRobotoFont:RobotoFontRegular size:18.f];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.auditoryLabel.font = [UIFont suaiRobotoFont:RobotoFontRegular size:18.f];
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
