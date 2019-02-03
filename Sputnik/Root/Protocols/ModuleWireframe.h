//
//  ModuleWireframe.h
//  SUAI_Navigation
//
//  Created by Виктор on 09/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol ModuleWireframe <NSObject>

@required
+ (UIViewController *)assembly;

@end
