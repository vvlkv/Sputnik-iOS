//
//  BUReferenceSearcher.h
//  SUAI_Navigation
//
//  Created by Виктор on 28/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceMainScreenContentProtocol.h"
#import "BUReferenceDataDisplayManager.h"

@interface BUReferenceSearcher : NSObject <BUReferenceMainScreenContentDelegate, BUReferenceMainScreenContentDataSource>

@property (weak, nonatomic) id <BUReferenceDataDisplayManagerDelegate> delegate;

- (instancetype)initWithReference:(NSArray *)referenceInfo;
- (void)searchEntitiesWithSearchText:(NSString *)searchText;

@end
