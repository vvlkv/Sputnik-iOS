//
//  BUToolbarView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUToolbarView.h"
#import "BUButton.h"

@interface BUToolbarView()<BUButtonDelegate> {
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
    
    fromButton = (BUButton *)[[NSBundle mainBundle] loadNibNamed:@"BUButton" owner:self options:nil][0];
    fromButton.userInteractionEnabled = YES;
    [fromButton setCancelButtonState:BUCancelStateHidden];
    [fromButton setTitle:@"Откуда"];
    fromButton.delegate = self;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:fromButton];
    
    UIButton *middle = [[UIButton alloc] init];
    middle.frame = CGRectMake(0, 0, 46, 30);
    [middle setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
    [middle addTarget:self action:@selector(invert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *centreItem = [[UIBarButtonItem alloc] initWithCustomView:middle];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    
    toButton = (BUButton *)[[NSBundle mainBundle] loadNibNamed:@"BUButton" owner:self options:nil][0];
    [toButton setCancelButtonState:BUCancelStateHidden];
    [toButton setTitle:@"Куда"];
    toButton.delegate = self;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:toButton];
    
    NSArray *items = [[NSArray alloc] initWithObjects:leftItem, flexibleSpace, centreItem, flexibleSpace, rightItem, nil];
    [self setItems:items];
}

- (void)setFromTitle:(NSString *)title {
    [fromButton setTitle:title];
    [fromButton setCancelButtonState:BUCancelStateVisible];
}

- (void)setToTitle:(NSString *)title {
    [toButton setTitle:title];
    [toButton setCancelButtonState:BUCancelStateVisible];
}


#pragma mark - Actions

- (void)fromAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:0];
}

- (void)toAction {
    [self.toolBarDelegate toolbarView:self buttonPressed:1];
}


#pragma mark - BUButtonDelegate

- (void)buttonSetAudioryDidPressed:(BUButton *)button {
    if ([button isEqual:toButton]) {
        [self toAction];
    } else {
        [self fromAction];
    }
}

- (void)buttonCancelDidPressed:(BUButton *)button {
    if ([button isEqual:fromButton]) {
        [self.toolBarDelegate toolbarView:self cancelButtonPressed:0];
        [fromButton setTitle:@"Откуда"];
    } else {
        [self.toolBarDelegate toolbarView:self cancelButtonPressed:1];
        [toButton setTitle:@"Куда"];
    }
}

- (void)invert {
    [self.toolBarDelegate invertAuditoriesInToolbarView:self];
}

@end
