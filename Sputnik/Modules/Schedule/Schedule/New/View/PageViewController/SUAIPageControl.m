//
//  SUAIPageControl.m
//  PageViewControllerTest
//
//  Created by Виктор on 16/12/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

#import "SUAIPageControl.h"

#import "UIColor+SUAI.h"

@interface SUAIPageControl() {
    NSArray<CATextLayer *> *titleLayers;
    NSArray<CAShapeLayer *> *markersLayer;
    NSArray<NSString *> *titles;
    CGFloat lineSize;
    NSUInteger pagesCount;
    BOOL lineAdded;
}

@property (strong, nonatomic) CAShapeLayer *lineLayer;

@end

const CGFloat selectorLineWidth = 3.f;

@implementation SUAIPageControl

- (instancetype)initWithTitles:(NSArray<NSString *> *)titlesVals
                    startIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _currentPage = index;
        titles = titlesVals;
        pagesCount = [titles count];
        markersLayer = [NSMutableArray array];
        lineSize = [[UIScreen mainScreen] bounds].size.width / pagesCount;
        [self initLineLayer];
        [self initTitles];
    }
    return self;
}

- (instancetype)init {
    return [self initWithTitles:[NSArray array] startIndex:0];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGFloat xPos = [touch locationInView:self].x;
    for (int i = 0; i < pagesCount; i++) {
        NSRange range = NSMakeRange(lineSize * i, lineSize);
        if (xPos > range.location && xPos < range.location + range.length)
            self.currentPage = i;
    }
}

- (void)drawRect:(CGRect)rect {
    [self addLine:rect];
    [self changeFrameForTitles:rect];
}

- (void)addLine:(CGRect)rect {
    [UIColor.redColor setStroke];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat multiplier = (CGFloat)_currentPage;
    [path moveToPoint:CGPointMake(multiplier * lineSize, rect.size.height - selectorLineWidth/2)];
    [path addLineToPoint:CGPointMake((multiplier + 1) * lineSize, rect.size.height - selectorLineWidth/2)];
    if (_lineLayer.path == nil) {
        _lineLayer.path = path.CGPath;
    }
    UIBezierPath *bottomLine = [[UIBezierPath alloc] init];
    [bottomLine moveToPoint:CGPointMake(0, rect.size.height)];
    [bottomLine addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [[UIColor lightGrayColor] setStroke];
    [bottomLine stroke];
}

- (void)initLineLayer {
    _lineLayer = [[CAShapeLayer alloc] init];
    _lineLayer.strokeColor = [[UIColor suaiPurpleColor] CGColor];
    _lineLayer.lineCap = kCALineCapRound;
    _lineLayer.lineWidth = selectorLineWidth;
    [self.layer addSublayer:_lineLayer];
}

- (void)initTitles {
    NSMutableArray *layers = [NSMutableArray arrayWithCapacity:pagesCount];
    for (int i = 0; i < pagesCount; i++) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.string = titles[i];
        textLayer.foregroundColor = i == _currentPage ? [UIColor suaiPurpleColor].CGColor : [[UIColor lightGrayColor] CGColor];
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.masksToBounds = YES;
        textLayer.contentsScale = [[UIScreen mainScreen] scale];
        [self.layer addSublayer:textLayer];
        [layers addObject:textLayer];
    }
    titleLayers = layers;
}

- (void)changeFrameForTitles:(CGRect)rect {
    CGFloat fontSize = 17.f;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    for (CATextLayer *layer in titleLayers) {
        NSUInteger i = [titleLayers indexOfObject:layer];
        layer.frame = CGRectMake(i * lineSize, 0, lineSize, rect.size.height);
        layer.font = (__bridge CFTypeRef)(font);
        layer.fontSize = fontSize;
        layer.position = CGPointMake(i * lineSize + lineSize / 2.0, rect.size.height - font.capHeight);
    }
}

- (void)fillMarkers:(NSArray *)markers {
    for (CAShapeLayer *layer in markersLayer) {
        [layer removeFromSuperlayer];
    }
    var *layersArray = [NSMutableArray array];
    for (int i = 0; i < [markers count]; i++) {
        NSUInteger intValue = [markers[i] unsignedIntegerValue];
        if (intValue == 0)
            continue;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        CGPoint arcCenter = CGPointMake(i * lineSize + lineSize * 8 / 9, self.frame.size.height / 5);
        CGFloat radius = 3.f;
        if (intValue == 1 || intValue == 2) {
            [path addArcWithCenter:arcCenter radius:radius startAngle:0 endAngle:2 * M_PI clockwise:true];
            layer.path = path.CGPath;
            if (intValue == 1)
                layer.fillColor = [[UIColor suaiRedColor] CGColor];
            else
                layer.fillColor = [[UIColor suaiBlueColor] CGColor];
        } else {
            [path addArcWithCenter:arcCenter radius:radius startAngle:0 endAngle:M_PI clockwise:true];
            layer.path = path.CGPath;
            layer.fillColor = [[UIColor suaiBlueColor] CGColor];
            [self.layer addSublayer:layer];
            [layersArray addObject:layer];
            layer = [[CAShapeLayer alloc] init];
            path = [[UIBezierPath alloc] init];
            [path addArcWithCenter:arcCenter radius:radius startAngle:0 endAngle:M_PI clockwise:false];
            layer.path = path.CGPath;
            layer.fillColor = [[UIColor suaiRedColor] CGColor];
        }
        [self.layer addSublayer:layer];
        [layersArray addObject:layer];
    }
    markersLayer = [layersArray copy];
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    NSUInteger oldPos = _currentPage;
    _currentPage = currentPage;
    [self animateLineFromOldPos:oldPos toNewPos:_currentPage];
}

- (void)animateLineFromOldPos:(NSUInteger)old toNewPos:(NSUInteger)new {
    [self.delegate pageControl:self didTapOnSectionAtIndex:new];
    [_lineLayer removeAllAnimations];
    CGFloat offset = (CGFloat)new - (CGFloat)old;
    CGFloat diff = offset * lineSize;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = .2f;
    animation.fromValue = [NSValue valueWithCGPoint:_lineLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_lineLayer.position.x + diff, _lineLayer.position.y)];
    [_lineLayer addAnimation:animation forKey:@"animatePosition"];
    _lineLayer.position = CGPointMake(_lineLayer.position.x + diff, _lineLayer.position.y);
    titleLayers[old].foregroundColor = [UIColor lightGrayColor].CGColor;
    titleLayers[new].foregroundColor = [UIColor suaiPurpleColor].CGColor;
}

@end
