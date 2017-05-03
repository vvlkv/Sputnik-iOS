//
//  BUAuditoryViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 26.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUAuditoryViewController;
@protocol BUAuditoryDelegate <NSObject>

@required
- (void)viewController:(BUAuditoryViewController *)viewController
         foundAuditory:(NSString *)auditory;

@end

@interface BUAuditoryViewController : UIViewController

@property (strong, nonatomic) NSString *titleText;
@property (weak, nonatomic) id <BUAuditoryDelegate> delegate;

@end
