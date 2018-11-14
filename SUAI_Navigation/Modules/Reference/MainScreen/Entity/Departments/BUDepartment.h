//
//  BUDepartment.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUInfoPlacedEntity.h"

@class BUHeader;
@class BULink;
@class BUSubdivision;
@interface BUDepartment : BUInfoPlacedEntity <NSCopying>

@property (strong, nonatomic) BUHeader *header;
@property (strong, nonatomic) BULink *link;
@property (readonly, nonatomic) NSArray<BUSubdivision *> *subdivisions;

@end
