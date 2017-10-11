//
//  BUTableHeaderView.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableHeaderView.h"
#import "UIFont+SUAI.h"

@interface BUTableHeaderView() {
    
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BUTableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    self.layer.borderWidth = .4f;
    self.layer.borderColor = [[UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:244.f/255.f alpha:1.f] CGColor];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        UITextView *tv = object;
        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
        CGFloat inset = MAX(0, deadSpace/2.0);
        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
    }
}

- (void)changeTextAlignment:(NSTextAlignment) alignment {
    [self.textView setTextAlignment:alignment];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textView.text = _title;
    self.textView.font = [UIFont suaiRobotoFont:RobotoFontMedium size:15.f];
}

- (void)dealloc {
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}

@end
