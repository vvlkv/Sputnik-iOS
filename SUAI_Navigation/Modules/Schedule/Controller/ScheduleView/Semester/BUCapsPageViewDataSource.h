//
//  BUCapsPageViewDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 02.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUCapsPageView;
@protocol BUCapsPageViewDataSource <NSObject>

@required
- (NSUInteger)capsPageView:(BUCapsPageView *)pageView dayTypeAtIndex:(NSUInteger)dayType;

@end
