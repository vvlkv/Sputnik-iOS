//
//  BUActivityIndicatorView.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUActivityIndicatorView.h"
#import "BUActivityIndicatorAnimation.h"

@implementation BUActivityIndicatorView

- (void)startAnimating {
    self.layer.sublayers = nil;
    BUActivityIndicatorAnimation *animation = [[BUActivityIndicatorAnimation alloc] init];
    [animation setupAnimationInLayer:self.layer withSize:CGSizeMake(40.f, 40.f) tintColor:[UIColor greenColor]];
    self.layer.speed = 1.3f;
}

- (void)stopAnimating {
    self.layer.speed = 0.0f;
}

@end
