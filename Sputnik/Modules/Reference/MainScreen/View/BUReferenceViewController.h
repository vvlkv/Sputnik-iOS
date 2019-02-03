//
//  BUReferenceViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 05/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUReferenceViewControllerInput.h"
#import "BUReferenceViewControllerOutput.h"
#import "BUReferenceMainScreenContentProtocol.h"

@interface BUReferenceViewController : BURootViewController <BUReferenceViewControllerInput>

@property (strong, nonatomic) id <BUReferenceViewControllerOutput> output;
@property (weak, nonatomic) id <BUReferenceMainScreenContentDelegate> delegate;
@property (weak, nonatomic) id <BUReferenceMainScreenContentDataSource> dataSource;

@end
