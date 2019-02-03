//
//  BUKVOProtocol.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUKVCProtocol <NSObject>

@required
- (void)setkvcValue:(id)value
          forKey:(NSString *)key;

@end
