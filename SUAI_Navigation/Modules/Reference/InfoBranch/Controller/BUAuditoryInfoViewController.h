//
//  BIAuditoryInfoViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUAuditoryInfoViewController;
@protocol BUAuditoryInfoViewControllerDelegate <NSObject>

- (void)viewController:(BUAuditoryInfoViewController *)viewController didDismissedWithAuditory:(NSString *)auditory;

@end

@interface BUAuditoryInfoViewController : UIViewController

@property (strong, nonatomic) id data;
@property (weak, nonatomic) id <BUAuditoryInfoViewControllerDelegate> delegate;

@end
