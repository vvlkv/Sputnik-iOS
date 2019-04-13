//
//  BUNewsViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsViewControllerInput <NSObject>

@required
- (void)updateContent;
- (void)showFailMessageWithText:(NSString *)text;

@end
