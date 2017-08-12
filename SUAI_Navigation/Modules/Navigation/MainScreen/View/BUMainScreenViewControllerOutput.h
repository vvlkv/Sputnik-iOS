//
//  BUMainScreenViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUMainScreenViewControllerOutput <NSObject>

@required
- (void)didWebViewLoaded;
- (void)didButtonPressed:(NSUInteger)index;
- (void)didCancelButtonPressed:(NSUInteger)index;
- (void)didCameraButtonPressed;
- (void)didReceivedAuditory:(NSString *)auditory;
- (void)didArrowPressed;
- (void)didWebViewLoadedWithCode:(NSInteger)code;
- (void)didNormalRouteSelected;

@end
