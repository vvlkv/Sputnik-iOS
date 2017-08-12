//
//  BUScheduleProtocol.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleProtocol <NSObject>

- (void)refresh;
- (void)updateFrame:(CGRect)frame;

@end
