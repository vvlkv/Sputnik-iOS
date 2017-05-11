//
//  BUSegmentedControl.m
//  SUAI_Navigation
//
//  Created by Виктор on 09.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSegmentedControl.h"

@interface BUSegmentedControl() {
    
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *control;

@end

@implementation BUSegmentedControl

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [[UIColor grayColor] CGColor];
  //  self.layer.borderWidth = .5f;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)segmentedControlChanged:(id)sender {
    [self.delegate segmentedControl:self indexWasChanged:_control.selectedSegmentIndex];
}

@end
