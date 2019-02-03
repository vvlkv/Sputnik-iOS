//
//  UIViewController+Anchor.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Anchor)

- (NSLayoutYAxisAnchor *)topAnchor;
- (NSLayoutYAxisAnchor *)bottomAnchor;
- (NSLayoutXAxisAnchor *)leftAnchor;
- (NSLayoutXAxisAnchor *)rightAnchor;

@end

NS_ASSUME_NONNULL_END
