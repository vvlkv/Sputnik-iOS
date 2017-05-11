//
//  BUButton.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUButton.h"

@interface BUButton() {
    
}

@property (weak, nonatomic) IBOutlet UIButton *auditoryButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation BUButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self standardInit];
}

- (void)standardInit {
    self.backgroundColor = [UIColor colorWithRed:0.f green:118.f/255.f blue:255.f/255.f alpha:1.0f];
    self.frame = CGRectMake(0, 0, 117, 30);
    self.layer.cornerRadius = 5.0f;
}

- (IBAction)setAuditory:(id)sender {
    [self.delegate buttonSetAudioryDidPressed:self];
}

- (IBAction)cancel:(id)sender {
    [self.delegate buttonCancelDidPressed:self];
    [self setCancelButtonState:BUCancelStateHidden];
}

- (void)setCancelButtonState:(BUCancelState)state {
    if (state == BUCancelStateHidden) {
        self.cancelButton.hidden = YES;
        self.cancelButton.userInteractionEnabled = NO;
    } else {
        self.cancelButton.userInteractionEnabled = YES;
        self.cancelButton.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title {
    [self.auditoryButton setTitle:title forState:UIControlStateNormal];
}

@end
