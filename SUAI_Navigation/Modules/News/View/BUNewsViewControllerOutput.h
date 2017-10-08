//
//  BUNewsViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsViewControllerOutput <NSObject>

@required
- (void)didSelectedCellAtIndex:(NSUInteger)index;

@optional
- (void)viewDidLoad;

@end
