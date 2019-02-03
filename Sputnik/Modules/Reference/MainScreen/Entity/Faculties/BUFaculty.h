//
//  BUFaculty.h
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUInfoEntity.h"

@class BUFacultyDepartment;
@class BUDean;
@interface BUFaculty : BUInfoEntity <NSCopying>

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) BUDean *dean;
@property (readonly, nonatomic) NSArray<BUFacultyDepartment *> *departments;

@end
