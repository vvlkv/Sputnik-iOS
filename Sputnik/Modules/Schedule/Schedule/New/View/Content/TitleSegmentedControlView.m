//
//  CustomControl.m
//  CustomSegmentedControl
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "TitleSegmentedControlView.h"
#import "BUCustomSegmentedControl.h"
#import "UIFont+SUAI.h"

@interface TitleSegmentedControlView() {
    NSString *_title;
    NSArray *_items;
}

@property (strong, nonatomic) BUCustomSegmentedControl *control;
@property (strong, nonatomic) CATextLayer *titleLayer;

@end

@implementation TitleSegmentedControlView

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items start:(NSUInteger)start {
    self = [super init];
    if (self) {
        _title = title;
        _items = items;
        [self addSegmentedControl:start];
        [self addTitleLayer];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSegmentedControl:(NSUInteger)start {
    _control = [[BUCustomSegmentedControl alloc] initWithItems:_items andType:BUSegmentTypeNormal];
    _control.selectedSegmentIndex = start;
    [_control addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_control];
}

- (void)addTitleLayer {
    CGFloat fontSize = 14.f;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    _titleLayer = [CATextLayer layer];
    _titleLayer.font = (__bridge CFTypeRef)(font);
    _titleLayer.fontSize = fontSize;
    _titleLayer.string = _title;
    _titleLayer.foregroundColor = UIColor.whiteColor.CGColor;
    _titleLayer.alignmentMode = kCAAlignmentCenter;
    _titleLayer.masksToBounds = YES;
    _titleLayer.contentsScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer:_titleLayer];
}

- (void)drawRect:(CGRect)rect {
    _control.frame = CGRectMake(8, 16, rect.size.width - 16, 25);
    CGFloat textWidth = rect.size.width;
    _titleLayer.frame = CGRectMake(0, 0, textWidth, rect.size.height);
}

- (void)segmentChanged:(UISegmentedControl *)control {
    [self.delegate segmentedControl:self didSelectSegmentIndex:control.selectedSegmentIndex];
}

- (void)setName:(NSString *)name {
    _title = name;
    _titleLayer.string = _title;
}

- (NSString *)name {
    return _title;
}

@end
