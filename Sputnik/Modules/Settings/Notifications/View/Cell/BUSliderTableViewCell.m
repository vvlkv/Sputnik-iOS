//
//  BUSliderTableViewCell.m
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSliderTableViewCell.h"

@interface BUSliderTableViewCell()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

static NSUInteger step = 5;

@implementation BUSliderTableViewCell

- (void)setSliderValue:(NSUInteger)sliderValue {
    _sliderValue = sliderValue;
    _slider.value = _sliderValue;
}

- (void)setTitleValue:(NSString *)titleValue {
    _titleValue = titleValue;
    [self p_configureTitleLabel];
}

- (IBAction)didChangeSliderValue:(id)sender {
    [_slider setValue:((int)((_slider.value + 2.5) / step) * step) animated:NO];
    _sliderValue = _slider.value;
    [self p_configureTitleLabel];
}

- (void)p_configureTitleLabel {
    _titleLabel.text = [NSString stringWithFormat:_titleValue, _sliderValue];
}

@end
