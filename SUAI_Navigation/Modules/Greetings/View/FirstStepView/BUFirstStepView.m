//
//  BUFirstStepViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUFirstStepView.h"
#import "UIFont+SUAI.h"

@interface BUFirstStepView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *whoAreYouLabel;

@end

@implementation BUFirstStepView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.whoAreYouLabel.text = @"Выберите, кто вы:";
    self.whoAreYouLabel.textColor = [UIColor whiteColor];
    [self.whoAreYouLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:17.f]];
}

- (IBAction)groupButton:(id)sender {
    [self.delegate didPressGroupButton];
}

- (IBAction)teacherButton:(id)sender {
    [self.delegate didPressTeacherButton];
}

- (IBAction)guestButton:(id)sender {
    [self.delegate didPressGuestButton];
}

@end
