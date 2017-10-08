//
//  BUNewsDetailInfoViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsDetailInfoViewControllerInput <NSObject>

@required
- (void)updateContent;
- (void)loadFailed;

@end
