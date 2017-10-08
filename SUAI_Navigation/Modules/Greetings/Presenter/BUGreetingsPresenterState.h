//
//  BUGreetingsPresenterState.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUGreetingsPresenterState : NSObject

@property (strong, nonatomic) NSArray *sortedCodesArray;
@property (assign, nonatomic) NSUInteger selectedEntitiesIndex;
@property (assign, nonatomic) NSUInteger chosenEntityIndex;
@property (strong, nonatomic) NSDictionary *codes;
@property (assign, nonatomic) BOOL isFailViewAlreadyInit;

@end
