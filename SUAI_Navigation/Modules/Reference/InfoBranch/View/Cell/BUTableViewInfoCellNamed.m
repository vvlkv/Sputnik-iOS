//
//  BUTableViewInfoCellNamed.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableViewInfoCellNamed.h"
#import "UIFont+SUAI.h"

@interface BUTableViewInfoCellNamed() {
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleDescriptionLabel;

@end

@implementation BUTableViewInfoCellNamed

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTitleDescription:(NSString *)titleDescription {
    _titleDescription = titleDescription;
    self.titleDescriptionLabel.text = _titleDescription;
    self.titleDescriptionLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:12.f];
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    self.imageLabel.image = image;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:17.f];
}

@end
