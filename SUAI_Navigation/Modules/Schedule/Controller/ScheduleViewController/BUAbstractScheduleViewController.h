//
//  BUAbstractScheduleViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 11.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUScheduleContentDataSource.h"
#import "BUScheduleViewControllerInput.h"
#import "BUScheduleViewControllerOutput.h"

@interface BUAbstractScheduleViewController : BURootViewController <BUScheduleViewControllerInput>

@property (strong, nonatomic) id <BUScheduleViewControllerOutput> output;
@property (weak, nonatomic) id <BUScheduleContentDataSource> tableContent;
@property (weak, nonatomic) id <BUScheduleContentDelegate> delegate;

- (void)animateSessionViewToRect:(CGRect)sessionRect andSemesterView:(CGRect)semesterRect;

@end
