//
//  BUCustomButtonView.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCustomButtonView.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BUCustomButtonView () {
    UIButton *auditoryButton;
    UIButton *cancelButton;
}

@end

@implementation BUCustomButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor suaiBlueColor];
    self.layer.cornerRadius = 4.f;
    self.userInteractionEnabled = YES;
    auditoryButton = [[UIButton alloc] initWithFrame:self.bounds];
    auditoryButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [auditoryButton addTarget:self action:@selector(auditoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [auditoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [auditoryButton.titleLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:18.f]];
    cancelButton = [[UIButton alloc] init];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [self addSubview:auditoryButton];
    [self addSubview:cancelButton];
    [[cancelButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
    [[cancelButton.widthAnchor constraintEqualToConstant:30] setActive:YES];
    [[cancelButton.heightAnchor constraintEqualToConstant:30] setActive:YES];
    [[cancelButton.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
}

- (void)setTitle:(NSString *)title {
    [auditoryButton setTitle:title forState:UIControlStateNormal];
}

- (void)setCancelButtonVisibility:(BOOL)isVisible {
    cancelButton.hidden = isVisible ^ 1;
    cancelButton.userInteractionEnabled = isVisible;
}

- (void)auditoryButtonPressed:(id)target {
    [self.delegate didPressedAuditoryButton:self];
}

- (void)cancelButtonPressed:(id)target {
    [self.delegate didPressedCancelButton:self];
}

@end
