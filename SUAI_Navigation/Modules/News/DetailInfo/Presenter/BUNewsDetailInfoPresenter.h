//
//  BUNewsDetailInfoPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNewsDetailInfoInteractorInput.h"
#import "BUNewsDetailInfoInteractorOutput.h"
#import "BUNewsDetailInfoViewControllerOutput.h"
#import "BUNewsDetailInfoViewControllerInput.h"
#import "BUNewsDetailInfoDataSource.h"

@interface BUNewsDetailInfoPresenter : NSObject <BUNewsDetailInfoInteractorOutput, BUNewsDetailInfoViewControllerOutput, BUNewsDetailInfoDataSource>

@property (weak, nonatomic) id <BUNewsDetailInfoViewControllerInput> view;
@property (strong, nonatomic) id <BUNewsDetailInfoInteractorInput> input;

@end
