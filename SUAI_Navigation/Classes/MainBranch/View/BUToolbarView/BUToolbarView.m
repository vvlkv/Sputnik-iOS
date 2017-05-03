//
//  BUToolbarView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUToolbarView.h"
#import "BUButton.h"

@interface BUToolbarView() {
    BUButton *fromButton;
    BUButton *toButton;
}

@end

@implementation BUToolbarView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5f];
    [self setButtons];
    return self;
}

- (void)setButtons {
    fromButton = [[BUButton alloc] init];
    [fromButton addTarget:self action:@selector(fromAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:fromButton];
    toButton = [[BUButton alloc] init];
    [toButton addTarget:self action:@selector(toAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:toButton];
    NSArray *items = [[NSArray alloc] initWithObjects:leftItem, flexibleSpace, rightItem, nil];
    [self setItems:items];
}

- (void)setFromTitle:(NSString *)title {
    [fromButton setTitle:title forState:UIControlStateNormal];
}

- (void)setToTitle:(NSString *)title {
    [toButton setTitle:title forState:UIControlStateNormal];
}

- (void)fromAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:0];
}

- (void)toAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:1];
}

@end
