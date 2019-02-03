//
//  CustomControl.h
//  CustomSegmentedControl
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TitleSegmentedControlView;
@protocol TitleSegmentedControlViewDelegate <NSObject>
@required
- (void)segmentedControl:(TitleSegmentedControlView *)control didSelectSegmentIndex:(NSUInteger)index;

@end

@interface TitleSegmentedControlView : UIView

@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) id <TitleSegmentedControlViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items start:(NSUInteger)start;

@end

NS_ASSUME_NONNULL_END
