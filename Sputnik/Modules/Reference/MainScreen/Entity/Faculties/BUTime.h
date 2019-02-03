//
//  BUTime.h
//  SUAI_Navigation
//
//  Created by Виктор on 26/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUKVCProtocol.h"

@interface BUTime : NSObject <NSCopying>

@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *time;

@end
