//
//  BUToolbarView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUToolbarView.h"
#import "BUCustomButtonView.h"

@interface BUToolbarView () <BUCustomButtonViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet BUCustomButtonView *fromButtonView;
@property (weak, nonatomic) IBOutlet BUCustomButtonView *toButtonView;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@end

@implementation BUToolbarView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [[NSBundle mainBundle] loadNibNamed:@"BUToolbarView" owner:self options:nil];
    [self addSubview:_contentView];
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self tuneToolbar];
}

- (void)tuneToolbar {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5f];
    [self setButtons];
}

- (void)setButtons {

    self.fromButtonView.delegate = self;
    [self.fromButtonView setTitle:@"Откуда"];
    [self.fromButtonView setCancelButtonVisibility:NO];
    
    self.toButtonView.delegate = self;
    [self.toButtonView setTitle:@"Куда"];
    [self.toButtonView setCancelButtonVisibility:NO];
    
    [[self.arrowButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    UIImage *arrowImage = [[UIImage imageNamed:@"Arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.arrowButton setImage:arrowImage forState:UIControlStateNormal];
    [self.arrowButton addTarget:self action:@selector(invert) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFromTitle:(NSString *)title {
    [self.fromButtonView setTitle:title];
    [self.fromButtonView setCancelButtonVisibility:YES];
}

- (void)setToTitle:(NSString *)title {
    [self.toButtonView setTitle:title];
    [self.toButtonView setCancelButtonVisibility:YES];
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
    if ([button isEqual:_fromButtonView]) {
        [self fromAction];
    } else {
        [self toAction];
    }
}

- (void)didPressedCancelButton:(BUCustomButtonView *)button {
    NSString *title;
    NSUInteger buttonIndex;
    
    if ([button isEqual:_fromButtonView]) {
        title = @"Откуда";
        buttonIndex = 0;
    } else {
        title = @"Куда";
        buttonIndex = 1;
    }
    
    [self.toolBarDelegate toolbarView:self cancelButtonPressed:buttonIndex];
    [button setTitle:title];
    [button setCancelButtonVisibility:NO];
}

- (void)invert {
    [self.toolBarDelegate invertAuditoriesInToolbarView:self];
}

@end
