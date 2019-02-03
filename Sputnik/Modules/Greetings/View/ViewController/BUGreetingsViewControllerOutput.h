//
//  BUGreetingsViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUGreetingsViewControllerOutput <NSObject>

- (void)viewDidLoad;
- (void)didSelectEntityType:(NSUInteger)type;
- (void)didSelectEntityAtIndex:(NSUInteger)index;
- (void)didConformSelection;

@end
