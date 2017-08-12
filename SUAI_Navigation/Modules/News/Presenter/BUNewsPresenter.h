//
//  BUNewsPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNewsViewControllerOutput.h"
#import "BUNewsViewControllerInput.h"
#import "BUNewsInteractorOutput.h"
#import "BUNewsDataSource.h"
#import "BUNewsRouterInput.h"
#import "BUNewsInteractorInput.h"

@interface BUNewsPresenter : NSObject <BUNewsViewControllerOutput, BUNewsInteractorOutput, BUNewsDataSource>

@property (weak, nonatomic) id <BUNewsViewControllerInput> view;
@property (strong, nonatomic) id <BUNewsInteractorInput> input;
@property (strong, nonatomic) id <BUNewsRouterInput> router;

@end
