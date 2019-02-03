//
//  BUAstronautView.m
//  SUAI_Navigation
//
//  Created by Виктор on 18.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAstronautView.h"
#import "UIFont+SUAI.h"

@interface BUAstronautView () {
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BUAstronautView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.image = [UIImage imageNamed:@"Austronaut"];
    [self.titleLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:24.f]];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.titleLabel.text = _message;
}

@end
