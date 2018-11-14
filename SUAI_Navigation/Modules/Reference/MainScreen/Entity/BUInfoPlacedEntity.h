//
//  BUInfoPlacedEntity.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUInfoEntity.h"
#import "BUKVCProtocol.h"

@interface BUInfoPlacedEntity : BUInfoEntity <NSCopying>

@property (strong, nonatomic) NSString *pos;
@property (strong, nonatomic) NSString *aud;

@end
