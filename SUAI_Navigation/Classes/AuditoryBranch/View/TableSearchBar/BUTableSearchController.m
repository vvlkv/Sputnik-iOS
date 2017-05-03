//
//  BUTableSearchController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableSearchController.h"

@interface BUTableSearchController ()

@end

@implementation BUTableSearchController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scopeButtonTitles = @[@"Аудитории", @"Институты", @"Отделы"];
    UIButton *cancelButton = ((UIButton *)[self valueForKey:@"cancelButton"]);
    [cancelButton setTitle:@"Отмена" forState:UIControlStateNormal];
    [self becomeFirstResponder];
    self.placeholder = @"Например, 1243";
    UIColor *color = [UIColor colorWithRed:250.f/255.f
                                     green:250.f/255.f
                                      blue:250.f/255.f
                                     alpha:90.f/100.f];
    CGRect imageRect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0);
    [color setFill];
    UIRectFill(imageRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setScopeBarBackgroundImage:image];
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    self.text = @"";
    return YES;
}

@end
