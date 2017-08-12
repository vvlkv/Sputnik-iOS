//
//  BUToolbarView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUToolbarView.h"
//#import "BUButton.h"
#import "BUCustomButtonView.h"

@interface BUToolbarView () <BUCustomButtonViewDelegate> {
    BUCustomButtonView *fromButtonView;
    BUCustomButtonView *toButtonView;
}

@end

@implementation BUToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5f];
    [self setButtons];
    return self;
}

- (void)setButtons {
    fromButtonView = [[BUCustomButtonView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    fromButtonView.delegate = self;
    [fromButtonView setTitle:@"Откуда"];
    fromButtonView.isCancelButtonVisible = NO;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:fromButtonView];
    UIButton *middle = [[UIButton alloc] init];
    middle.frame = CGRectMake(0, 0, 46, 30);
    [middle setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
    [middle addTarget:self action:@selector(invert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *centreItem = [[UIBarButtonItem alloc] initWithCustomView:middle];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    
    toButtonView = [[BUCustomButtonView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    toButtonView.delegate = self;
    [toButtonView setTitle:@"Куда"];
    toButtonView.isCancelButtonVisible = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:toButtonView];
    NSArray *items = [[NSArray alloc] initWithObjects:leftItem, flexibleSpace, centreItem, flexibleSpace, rightItem, nil];
    self.items = items;
}

- (void)setFromTitle:(NSString *)title {
    [fromButtonView setTitle:title];
    fromButtonView.isCancelButtonVisible = YES;
}

- (void)setToTitle:(NSString *)title {
    [toButtonView setTitle:title];
    toButtonView.isCancelButtonVisible = YES;
}


#pragma mark - Actions

- (void)fromAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:0];
}

- (void)toAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:1];
}


#pragma mark - BUCustomButtonViewDelegate

- (void)didPressedAuditoryButton:(BUCustomButtonView *)button {
    if ([button isEqual:fromButtonView]) {
        [self fromAction];
    } else {
        [self toAction];
    }
}

- (void)didPressedCancelButton:(BUCustomButtonView *)button {
    if ([button isEqual:fromButtonView]) {
        [self.toolBarDelegate toolbarView:self cancelButtonPressed:0];
        [fromButtonView setTitle:@"Откуда"];
        fromButtonView.isCancelButtonVisible = NO;
    } else {
        [self.toolBarDelegate toolbarView:self cancelButtonPressed:1];
        [toButtonView setTitle:@"Куда"];
        toButtonView.isCancelButtonVisible = NO;
    }
}

- (void)invert {
    [self.toolBarDelegate invertAuditoriesInToolbarView:self];
}

@end
