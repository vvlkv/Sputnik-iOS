//
//  BUReferenceDetailInfoViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceTableViewDataSource.h"

@protocol BUReferenceDetailInfoViewControllerOutput <NSObject>

- (void)viewDidLoad;
- (void)didPressOnEntityAdIndex:(NSUInteger)index;
- (void)didPressOnAbout;
- (void)didPressOnAction;
- (void)didPerformActionWithItem:(id <BUReferenceViewModelItemProtocol>)item;
- (id <BUReferenceTableViewDataSource>)dataSource;

@end
