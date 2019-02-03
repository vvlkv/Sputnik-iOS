//
//  BUWeekDescriptionView.m
//  SUAI_Navigation
//
//  Created by Виктор on 14.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUWeekDescriptionView.h"
#import "UIFont+SUAI.h"

@interface BUWeekDescriptionView () {
    
}

@property (weak, nonatomic) UILabel *weekDescriptionLabel;

@end

@implementation BUWeekDescriptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, frame.size.width - 8, frame.size.height)];
        self.backgroundColor = [UIColor whiteColor];
        weekLabel.font = [UIFont suaiRobotoFont:RobotoFontBold size:24.f];
        [self addSubview:weekLabel];
        self.weekDescriptionLabel = weekLabel;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *weekLabel = [[UILabel alloc] init];
        [self addSubview:weekLabel];
        weekLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [[weekLabel.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
        [[weekLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
        [[weekLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:8] setActive:YES];
        [[weekLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
        self.backgroundColor = [UIColor clearColor];
        weekLabel.font = [UIFont suaiRobotoFont:RobotoFontBold size:24.f];
        self.weekDescriptionLabel = weekLabel;
    }
    return self;
}

- (void)setWeekDescription:(NSString *)weekDescription {
    _weekDescription = weekDescription;
    self.weekDescriptionLabel.text = _weekDescription;
}

@end
