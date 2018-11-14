//
//  BULink.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUKVCProtocol.h"

@interface BULink : NSObject <BUKVCProtocol, NSCopying>

@property (strong, nonatomic) NSString *site;
@property (strong, nonatomic) NSString *mail;

@end
