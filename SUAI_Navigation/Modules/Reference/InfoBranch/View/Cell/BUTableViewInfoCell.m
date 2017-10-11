//
//  BUTableViewInfoCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableViewInfoCell.h"

@interface BUTableViewInfoCell() {
    
}

@end

@implementation BUTableViewInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setImage:(UIImage *)image {
    _image = image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
}

@end
