//
//  BUHeader.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUInfoPlacedEntity.h"

@interface BUHeader : BUInfoPlacedEntity <NSCopying>

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *mail;

@end
