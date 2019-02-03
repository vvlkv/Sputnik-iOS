//
//  BUSettingsViewModel.h
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsViewModelItem.h"

@interface BUSettingsViewModelEntity : NSObject <BUSettingsViewModelItem>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;

@end
