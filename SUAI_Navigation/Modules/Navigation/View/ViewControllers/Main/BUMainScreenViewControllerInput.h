//
//  BUMainScreenViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUMainScreenViewControllerInput <NSObject>

@required
//- (NSInteger)showAuditory:(NSString *)auditory;
- (void)showAuditory:(NSString *)auditory errCode:(void (^)(NSInteger code))errorCode;
- (void)setContent:(NSString *)content forButtonAtIndex:(NSUInteger)index;
- (void)showPathFrom:(NSString *)fromAuditory to:(NSString *)toAuditory;
- (void)showStartScreen;
- (void)showNormalAlert;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message andAction:(NSString *)action;
- (void)stopAnimating;
- (void)startAnimating;

@end
