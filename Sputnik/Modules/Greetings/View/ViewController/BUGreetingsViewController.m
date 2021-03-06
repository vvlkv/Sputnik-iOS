//
//  BUGreetingsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsViewController.h"
#import "UIFont+SUAI.h"
#import "UIImage+Gradient.h"
#import "UIColor+SUAI.h"
#import "BUFirstStepView.h"
#import "BUSecondStepView.h"
#import "BUFailView.h"

@interface BUGreetingsViewController () <BUFirtStepViewDelegate, BUSecondStepViewDelegate, BUFailViewDelegate> {
    BUFirstStepView *firstView;
    BUSecondStepView *secondView;
    BUFailView *failView;
    UIActivityIndicatorView *indicatorView;
}

@property (weak, nonatomic) IBOutlet UILabel *greetingsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

NSString *const firstStepView = @"BUFirstStepView";
NSString *const secondStepView = @"BUSecondStepView";
NSString *const failViewName = @"BUFailView";

@implementation BUGreetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.greetingsLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:25.f]];
    self.greetingsLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.output viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CAGradientLayer *layer = [UIColor suaiGradientColorFrom:[UIColor suaiBlueColor]
                                                         to:[UIColor suaiLightPurpleColor]];
    layer.frame = self.view.frame;
    [self.backgroundImage setImage:[UIImage imageFromLayer:layer]];
}


#pragma mark - BUGreetingsViewControllerInput

- (void)initGreetingsView {
    [indicatorView stopAnimating];
    firstView = (BUFirstStepView *)[[NSBundle mainBundle] loadNibNamed:firstStepView
                                                                 owner:self
                                                               options:nil][0];
    firstView.delegate = self;
    CGRect firstViewFrame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    firstView.frame = firstViewFrame;
    
    secondView = (BUSecondStepView *)[[NSBundle mainBundle] loadNibNamed:secondStepView
                                                                   owner:self
                                                                 options:nil][0];
    secondView.delegate = self;
    secondView.dataSource = self.dataSource;
    CGRect secondViewFrame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    secondView.frame = secondViewFrame;
    [self.view addSubview:firstView];
    [self.view addSubview:secondView];
}

- (void)initFailView {
    failView = (BUFailView *)[[NSBundle mainBundle] loadNibNamed:failViewName
                                                           owner:self
                                                         options:nil][0];
    
    failView.delegate = self;
    CGRect frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    failView.frame = frame;
    [self.view addSubview:failView];
}

- (void)removeFailView {
    [failView removeFromSuperview];
}

- (void)reloadData {
    [secondView reloadPicker];
}


#pragma mark - BUFirtStepViewDelegate

- (void)didPressTeacherButton {
    [self animateEntityView];
    [self.output didSelectEntityType:1];
    [secondView reloadPicker];
}

- (void)didPressGroupButton {
    [self animateEntityView];
    [self.output didSelectEntityType:0];
    [secondView reloadPicker];
}

- (void)didPressGuestButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - BUSecondStepViewDelegate

- (void)didPressBackButton {
    CGRect secondViewOffset = CGRectMake(self.view.frame.size.width, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    CGRect firstViewOffset = secondView.frame;
    [self animateFirstView:firstViewOffset andSecond:secondViewOffset];
}

- (void)didPressContinueButton {
    [self.output didConformSelection];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectEntityAtIndex:(NSUInteger)index {
    [self.output didSelectEntityAtIndex:index];
}


#pragma mark - BUFailViewDelegate

- (void)didPressOkButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Animations

- (void)animateFirstView:(CGRect)firstRect andSecond:(CGRect)secondRect {
    [UIView animateWithDuration:0.3 animations:^{
        self->firstView.frame = firstRect;
        self->secondView.frame = secondRect;
    }];
}

- (void)animateEntityView {
    CGRect firstViewOffset = CGRectMake(-self.view.frame.size.width, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    CGRect secondViewOffset = firstView.frame;
    [self animateFirstView:firstViewOffset andSecond:secondViewOffset];
}

@end
