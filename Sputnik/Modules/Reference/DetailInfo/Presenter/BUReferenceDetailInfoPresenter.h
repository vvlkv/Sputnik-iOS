//
//  BUReferenceDetailInfoPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceDetailInfoViewControllerOutput.h"
#import "BUReferenceDetailInfoInteractorOutput.h"

@protocol BUReferenceDetailInfoInteractorInput;
@protocol BUReferenceDetailInfoViewControllerInput;
@protocol BUReferenceDetailInfoRouterInput;
@protocol BUReferenceMainScreenRouterInput;

@interface BUReferenceDetailInfoPresenter : NSObject <BUReferenceDetailInfoViewControllerOutput, BUReferenceDetailInfoInteractorOutput>

@property (weak, nonatomic) id <BUReferenceDetailInfoViewControllerInput> view;
@property (strong, nonatomic) id <BUReferenceMainScreenRouterInput> router;
@property (strong, nonatomic) id <BUReferenceDetailInfoInteractorInput> input;

@end
