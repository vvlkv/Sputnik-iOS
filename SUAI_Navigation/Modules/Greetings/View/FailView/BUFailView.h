//
//  BUFailView.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUFailViewDelegate <NSObject>

@required
- (void)didPressOkButton;

@end

@interface BUFailView : UIView

@property (weak, nonatomic) id <BUFailViewDelegate> delegate;

@end
