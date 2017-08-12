//
//  BUSecondStepViewGroup.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSecondStepView.h"

@interface BUSecondStepView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UILabel *whoAreYouLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *entityPicker;

@end

@implementation BUSecondStepView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.entityPicker.dataSource = self;
    self.entityPicker.delegate = self;
    self.entityPicker.layer.cornerRadius = 16.f;
    self.whoAreYouLabel.textColor = [UIColor whiteColor];
}

- (void)reloadPicker {
    [self.entityPicker reloadComponent:0];
    self.whoAreYouLabel.text = [self.dataSource greetingsText];
}


#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataSource pickerViewItemAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.delegate didSelectEntityAtIndex:row];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource numberOfItemsForPickerView];
}

- (IBAction)backButtonAction:(id)sender {
    [self.delegate didPressBackButton];
}

- (IBAction)continueButton:(id)sender {
    [self.delegate didPressContinueButton];
}

@end
