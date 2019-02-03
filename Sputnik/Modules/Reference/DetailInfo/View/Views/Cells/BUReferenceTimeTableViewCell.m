//
//  BUReferenceTimeTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceTimeTableViewCell.h"
#import "BUReferenceViewModelTimeItem.h"
#import "UIFont+SUAI.h"

@interface BUReferenceTimeTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BUReferenceTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 15.f : 17.f;
    [self.dayLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
    [self.timeLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    BUReferenceViewModelTimeItem *time = (BUReferenceViewModelTimeItem *)model;
    self.dayLabel.text = [time nameDescription];
    self.timeLabel.text = [time value];
}

@end
