//
//  BUScheduleSearchViewControllerOutput.h
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleSearchViewControllerOutput_h
#define BUScheduleSearchViewControllerOutput_h

@protocol BUScheduleSearchViewControllerOutput <NSObject>
@required
- (void)didChangeSearchContent:(NSString *)searchString;
- (void)didSelectRowAtSection:(NSUInteger)section row:(NSUInteger)row;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSString *)titleForHeaderInSection:(NSUInteger)section;
- (NSString *)textForRowInSection:(NSUInteger)section atRow:(NSUInteger)row;

@end

#endif /* BUScheduleSearchViewControllerOutput_h */
