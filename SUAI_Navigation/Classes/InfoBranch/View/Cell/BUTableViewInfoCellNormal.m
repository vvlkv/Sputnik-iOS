//
//  BUTableViewInfoCellNormal.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableViewInfoCellNormal.h"
#import "UIFont+SUAI.h"

@interface BUTableViewInfoCellNormal() {
    
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;

@end

@implementation BUTableViewInfoCellNormal

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    self.imageLabel.image = image;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.textView.text = title;
    self.textView.font = [UIFont suaiRobotoFont:RobotoFontLight size:17.f];
}

@end
