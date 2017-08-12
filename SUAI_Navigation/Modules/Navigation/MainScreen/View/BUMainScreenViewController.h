//
//  BUMainScreenViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUMainScreenViewControllerInput.h"
#import "BUMainScreenViewControllerOutput.h"

@interface BUMainScreenViewController : BURootViewController <BUMainScreenViewControllerInput>

@property (strong, nonatomic) id <BUMainScreenViewControllerOutput> output;

- (void)receiveAuditory:(NSString *)auditory;

@end
