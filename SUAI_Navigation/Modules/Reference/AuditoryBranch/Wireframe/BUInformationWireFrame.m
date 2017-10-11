//
//  BUInformationWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUInformationWireFrame.h"
#import "BUAuditoryViewController.h"
#import "BUInformationRouter.h"

@implementation BUInformationWireFrame

+ (UIViewController *)assemblyInformation {
    BUAuditoryViewController *infoVC = [[BUAuditoryViewController alloc] init];
    BUInformationRouter *infoRouter = [[BUInformationRouter alloc] init];
    infoVC.delegate = infoRouter;
    return infoVC;
}

@end
