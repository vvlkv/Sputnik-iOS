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

static NSUInteger step = 1;

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
    [_slider setValue:((int)((_slider.value + .5f) / step) * step) animated:NO];
    _sliderValue = _slider.value;
    [self p_configureTitleLabel];
}

- (void)p_configureTitleLabel {
    NSString *minuteName = @"минут";
    if (_sliderValue == 1.f)
        minuteName = @"минуту";
    if (_sliderValue > 1.f && _sliderValue < 5.f)
        minuteName = @"минуты";
    _titleLabel.text = [NSString stringWithFormat:_titleValue, _sliderValue, minuteName];
}

@end
