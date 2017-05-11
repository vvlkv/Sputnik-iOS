//
//  BUSegmentedControl.h
//  SUAI_Navigation
//
//  Created by Виктор on 09.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUSegmentedControl;
@protocol BUSegmentedControlDelegate <NSObject>

@required
- (void)segmentedControl:(BUSegmentedControl *)control indexWasChanged:(NSUInteger)index;

@end

@interface BUSegmentedControl : UIView

@property (weak, nonatomic) id <BUSegmentedControlDelegate> delegate;

@end
