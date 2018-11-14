//
//  BUInfoEntity.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUKVCProtocol.h"

@interface BUInfoEntity : NSObject <BUKVCProtocol, NSCopying>

@property (strong, nonatomic) NSString *name;

@end
