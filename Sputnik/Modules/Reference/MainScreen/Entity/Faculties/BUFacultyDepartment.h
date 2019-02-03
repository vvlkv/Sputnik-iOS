//
//  BUDepartment.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUInfoEntity.h"

@class BUHeader;
@class BULink;
@interface BUFacultyDepartment : BUInfoEntity

@property (strong, nonatomic) BUHeader *header;
@property (strong, nonatomic) BULink *link;
@property (strong, nonatomic) NSString *number;

@end
