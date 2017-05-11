//
//  BUTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableViewCell.h"

@interface BUTableViewCell() {
    
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BUTableViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textView.text = title;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textView.textColor = textColor;
}
@end
