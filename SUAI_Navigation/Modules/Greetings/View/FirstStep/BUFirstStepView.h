//
//  BUFirstStepViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUFirtStepViewDelegate <NSObject>

@required
- (void)didPressTeacherButton;
- (void)didPressGroupButton;
- (void)didPressdGuestButton;

@end

@interface BUFirstStepView : UIView

@property (weak, nonatomic) id <BUFirtStepViewDelegate> delegate;

@end
