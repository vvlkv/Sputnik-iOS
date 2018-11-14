//
//  BUReferenceMainScreenPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceMainScreenPresenterInput.h"
#import "BUReferenceViewControllerOutput.h"
#import "BUReferenceViewControllerInput.h"
#import "BUReferenceMainScreenInteractorInput.h"
#import "BUreferenceMainScreenInteractorOutput.h"
#import "BUReferenceMainScreenRouterInput.h"

@interface BUReferenceMainScreenPresenter : NSObject <BUReferenceMainScreenPresenterInput, BUReferenceViewControllerOutput, BUreferenceMainScreenInteractorOutput>

@property (weak, nonatomic) id <BUReferenceViewControllerInput> view;
@property (strong, nonatomic) id <BUReferenceMainScreenInteractorInput> input;
@property (strong, nonatomic) id <BUReferenceMainScreenRouterInput> router;

@end
