//
//  BUNavigationRouterOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNavigationRouterOutput <NSObject>

@required
- (void)didScannedCode:(NSString *)code;
- (void)didFoundAuditory:(NSString *)auditory;

@end
