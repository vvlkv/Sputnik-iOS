//
//  BUGreetingsViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUGreetingsViewControllerOutput <NSObject>

- (void)didObtainEntitiesAtIndex:(NSUInteger)index;
- (void)didEntitySelectedAtIndex:(NSUInteger)index;
- (void)didConformedSelection;

@end
