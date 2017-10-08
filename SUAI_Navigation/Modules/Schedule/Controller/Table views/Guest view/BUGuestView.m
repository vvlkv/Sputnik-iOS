//
//  BUGuestView.m
//  SUAI_Navigation
//
//  Created by Виктор on 08.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGuestView.h"
#import "BUCustomButtonView.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BUGuestView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation BUGuestView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageLabel.text = @"Выберите, пожалуйста, группу или преподавателя в настройках";
    self.messageLabel.font = [UIFont suaiRobotoFont:RobotoFontMedium size:17.f];
}

- (IBAction)jumpToSettingsButton:(id)sender {
    [self.delegate didPressJumpToSettingsButtonInGuestView:self];
}

@end
