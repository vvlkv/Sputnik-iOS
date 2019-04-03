//
//  BUScrollViewUpdater.m
//  CustomTransition
//
//  Created by Виктор on 26/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUScrollViewUpdater.h"
#import <UIKit/UIKit.h>

@interface BUScrollViewUpdater() {
    
}

@property (weak, nonatomic) UIView *rootView;
@property (weak, nonatomic) UIScrollView *scrollView;

@end

NSString *const kPropertyName = @"contentOffset";

@implementation BUScrollViewUpdater

- (instancetype)initWithRootView:(UIView *)root andScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        _rootView = root;
        _scrollView = scrollView;
        [_scrollView addObserver:self forKeyPath:kPropertyName options:NSKeyValueObservingOptionInitial context:nil];
    }
    return self;
}


- (void)scrollViewDidScroll {
    CGFloat offset = _scrollView.contentOffset.y + _scrollView.contentInset.top;
    if (offset > 0) {
        _scrollView.bounces = YES;
        _shouldDissmiss = NO;
    } else {
        if ([_scrollView isDecelerating]) {
            
        } else {
            _scrollView.bounces = NO;
            _shouldDissmiss = YES;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kPropertyName]) {
        [self scrollViewDidScroll];
    }
}

- (void)dealloc {
    [_scrollView removeObserver:self forKeyPath:kPropertyName];
}
@end
