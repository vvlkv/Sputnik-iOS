//
//  BUScheduleDataManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BUScheduleDataManager : NSObject

- (NSManagedObjectContext *)objectContext;

@end
