//
//  ChooseEntityMessageView.m
//  Sputnik
//
//  Created by Виктор on 21/03/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "ChooseEntityMessageView.h"
#import "UIFont+SUAI.h"

@interface ChooseEntityMessageView()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ChooseEntityMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_messageLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:15.f]];
}

- (IBAction)goToSettingsButton:(id)sender {
    [self.delegate didTapOnGoToSettingsButtonInMessageView:self];
}

- (void)setMessageText:(NSString *)messageText {
    _messageText = messageText;
    self.messageLabel.text = messageText;
}

- (void)setIsButtonHidden:(BOOL)isButtonVisible {
    _isButtonHidden = isButtonVisible;
    _button.hidden = _isButtonHidden;
}

@end
