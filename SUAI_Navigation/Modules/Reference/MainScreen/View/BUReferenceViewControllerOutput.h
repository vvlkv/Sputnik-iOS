//
//  BUReferenceViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceMainScreenContentProtocol.h"

@protocol BUReferenceViewControllerOutput <NSObject>

@required
- (void)didPressSegmentController:(NSUInteger)index;
- (void)didEnterSearchText:(NSString *)searchText;
- (id <BUReferenceMainScreenContentDataSource>)dataSource;
- (id <BUReferenceMainScreenContentDelegate>)delegate;
- (id <BUReferenceMainScreenContentDataSource>)searchDataSource;
- (id <BUReferenceMainScreenContentDelegate>)searchDelegate;

@end
