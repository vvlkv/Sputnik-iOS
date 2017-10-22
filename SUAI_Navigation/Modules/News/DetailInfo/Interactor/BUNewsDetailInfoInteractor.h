//
//  BUNewsDetailInfoInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNewsDetailInfoInteractorInput.h"
#import "BUNewsDetailInfoInteractorOutput.h"

@interface BUNewsDetailInfoInteractor : NSObject <BUNewsDetailInfoInteractorInput>

@property (weak, nonatomic) id <BUNewsDetailInfoInteractorOutput> output;

- (instancetype)initWithNewsId:(NSString *)newsId;

@end
