//
//  BUReferenceTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceTableViewCell.h"
#import "UIFont+SUAI.h"

@interface BUReferenceTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BUReferenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 15.f : 17.f;
    [self.nameLabel setFont:[UIFont suaiRobotoFont:RobotoFontBold size:fontSize]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = _name;
}

@end
