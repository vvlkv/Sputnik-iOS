//
//  BUFailView.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUFailView.h"
#import "UIFont+SUAI.h"

@interface BUFailView () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorDescriptionLabel;

@end

@implementation BUFailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.errorLabel.text = @"Соединение с интернетом не установлено :(";
    self.errorLabel.textColor = [UIColor whiteColor];
    [self.errorLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:17.f]];
    self.errorDescriptionLabel.text = @"В настройках вы сможете выбрать группу при подключении к сети";
    self.errorDescriptionLabel.textColor = [UIColor whiteColor];
    [self.errorDescriptionLabel setFont:[UIFont suaiRobotoFont:RobotoFontLight size:14.f]];
}

- (IBAction)okButton:(id)sender {
    [self.delegate didPressOkButton];
}

@end
