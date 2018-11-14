//
//  BUSubdivision.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUInfoPlacedEntity.h"

@class BULink;
@class BUHeader;
@class BUTime;

@interface BUSubdivision : BUInfoPlacedEntity

@property (strong, nonatomic) BULink *link;
@property (strong, nonatomic) BUHeader *header;
@property (strong, nonatomic) NSArray <BUTime *> *time;

@end
