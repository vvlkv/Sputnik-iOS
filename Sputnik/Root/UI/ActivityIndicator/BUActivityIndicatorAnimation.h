//
//  BUActivityIndicatorAnimation.h
//  SUAI_Navigation
//
//  Created by Виктор on 26/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUActivityIndicatorAnimation : NSObject

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
