//
//  BUSegmentedControl.m
//  SUAI_Navigation
//
//  Created by Виктор on 15.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCustomSegmentedControl.h"
#import "UIColor+SUAI.h"

@implementation BUCustomSegmentedControl

- (instancetype)initWithItems:(NSArray *)items andType:(BUSegmentType)type
{
    self = [super initWithItems:items];
    if (self) {
        UIColor *purpleColor = [UIColor suaiPurpleColor];
        self.tintColor = purpleColor;
        self.selectedSegmentIndex = 0;
        
        [self addTarget:self
                 action:@selector(segmentChanged:)
       forControlEvents:UIControlEventValueChanged];
        
        NSDictionary *normalAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil];
        [self setTitleTextAttributes:normalAttributes forState:UIControlStateSelected];
        if (type == BUSegmentTypeWhite) {
            [self setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
        }
        
    }
    return self;
}

- (void)segmentChanged:(id)sender {
    [self.delegate customSegment:self selectedScopeButtonIndexDidChange:[self selectedSegmentIndex]];
}

@end
