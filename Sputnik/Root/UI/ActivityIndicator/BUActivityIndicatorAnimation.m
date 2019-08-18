//
//  BUActivityIndicatorAnimation.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUActivityIndicatorAnimation.h"
#import "UIColor+SUAI.h"

@implementation BUActivityIndicatorAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size {
    double beginTime = 0.5;
    double strokeStartDuration = 1.2;
    double strokeEndDuration = 0.7;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(M_PI * 2.);
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = strokeEndDuration;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = strokeStartDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.beginTime = beginTime;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[rotationAnimation, strokeEndAnimation, strokeStartAnimation];
    groupAnimation.duration = strokeStartDuration + beginTime;
    groupAnimation.repeatCount = CGFLOAT_MAX;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(size.width/2, size.height/2)
                    radius:size.width/2 - 1.5f startAngle:M_PI_2 * (-1.f) endAngle:M_PI * 3. / 2. clockwise:YES];
    
    CGFloat xPos = (layer.bounds.size.width - size.width) / 2;
    CGFloat yPos = (layer.bounds.size.height - size.height) / 2;
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor blackColor].CGColor;
    circle.lineWidth = 3.f;
    circle.lineCap = kCALineJoinRound;
    circle.path = path.CGPath;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0, .5f);
    gradient.endPoint = CGPointMake(1, .5f);
    gradient.colors = @[(id)[UIColor suaiBlueColor].CGColor, (id)[UIColor suaiLightPurpleColor].CGColor];
    gradient.frame = CGRectMake(xPos, yPos, size.width, size.height);
    circle.frame = gradient.bounds;
    [gradient setMask:circle];
    [gradient addAnimation:groupAnimation forKey:@"animation"];
    [circle addAnimation:groupAnimation forKey:@"animation"];
    [layer addSublayer:gradient];
}

@end
