//
//  BUNewsDetailInfoTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoTableViewCell.h"
#import "UIFont+SUAI.h"

@interface BUNewsDetailInfoTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTextLabel;

@end

@implementation BUNewsDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:15.f];
    self.headerLabel.font = [UIFont suaiRobotoFont:RobotoFontBold size:18.f];
    self.subHeaderLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:18.f];
    self.newsTextLabel.font = [UIFont suaiRobotoFont:RobotoFontLight size:16.f];
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

- (void)setSubHeader:(NSString *)subHeader {
    _subHeader = subHeader;
    self.subHeaderLabel.text = _subHeader;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.newsTextLabel.text =_text;
}

@end
