//
//  BUNewsTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsTableViewCell.h"
#import "UIFont+SUAI.h"

@interface BUNewsTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@end

@implementation BUNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:15.f];
    self.headerLabel.font = [UIFont suaiRobotoFont:RobotoFontBold size:18.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDate:(NSString *)date {
    _date = date;
    self.dateLabel.text = _date;
}

- (void)setHeader:(NSString *)header {
    _header = header;
    self.headerLabel.text = _header;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.newsImageView.image = _image;
}

@end
