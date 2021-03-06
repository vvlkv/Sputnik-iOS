//
//  NSString+Dash.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Dash)

+ (NSString *)prepareToCall:(NSString *)number;
+ (NSString *)prepareAuditoryToLoad:(NSString *)string;

@end
