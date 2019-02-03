//
//  BUReferenceDetailInfoViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 13/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUReferenceTableViewDataSource.h"
#import "BUReferenceDetailInfoViewControllerOutput.h"
#import "BUReferenceDetailInfoViewControllerInput.h"

@interface BUReferenceDetailInfoViewController : BURootViewController <BUReferenceDetailInfoViewControllerInput>

@property (weak, nonatomic) id <BUReferenceTableViewDataSource> dataSource;
@property (strong, nonatomic) id <BUReferenceDetailInfoViewControllerOutput> output;

@end
