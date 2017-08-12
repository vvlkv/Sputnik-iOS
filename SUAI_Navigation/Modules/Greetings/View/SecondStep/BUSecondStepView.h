//
//  BUSecondStepViewGroup.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUSecondStepViewDataSource.h"

@class BUSecondStepView;
@protocol BUSecondStepViewDelegate <NSObject>

@required
- (void)didPressBackButton;
- (void)didPressContinueButton;
- (void)didSelectEntityAtIndex:(NSUInteger)index;

@end

@interface BUSecondStepView : UIView

@property (weak, nonatomic) id <BUSecondStepViewDelegate> delegate;
@property (weak, nonatomic) id <BUSecondStepViewDataSource> dataSource;

- (void)reloadPicker;

@end
