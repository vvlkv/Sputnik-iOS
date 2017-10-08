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
        self.backgroundColor = [UIColor suaiBlueColor];
        self.layer.cornerRadius = 5.f;
        self.userInteractionEnabled = YES;
        auditoryButton = [[UIButton alloc] initWithFrame:self.frame];
        [auditoryButton addTarget:self action:@selector(auditoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [auditoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [auditoryButton.titleLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:18.f]];
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 30, frame.size.height/2 - 15, 30, 30)];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
        [self addSubview:auditoryButton];
        [self addSubview:cancelButton];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [auditoryButton setTitle:title forState:UIControlStateNormal];
}

- (void)setIsCancelButtonVisible:(BOOL)isCancelButtonVisible {
    _isCancelButtonVisible = isCancelButtonVisible;
    cancelButton.hidden = _isCancelButtonVisible ^ 1;
    cancelButton.userInteractionEnabled = _isCancelButtonVisible;
}

- (void)auditoryButtonPressed:(id)target {
    [self.delegate didPressedAuditoryButton:self];
}

- (void)cancelButtonPressed:(id)target {
    [self.delegate didPressedCancelButton:self];
}

@end
