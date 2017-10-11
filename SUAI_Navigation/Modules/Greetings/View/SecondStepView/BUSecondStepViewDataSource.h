//
//  BUSecondStepViewDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSecondStepViewDataSource <NSObject>

@required

- (NSString *)greetingsText;
- (NSUInteger)numberOfItemsForPickerView;
- (NSString *)pickerViewItemAtIndex:(NSUInteger)index;

@end
