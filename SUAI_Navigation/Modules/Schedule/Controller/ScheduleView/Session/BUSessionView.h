//
//  BUSessionView.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUScheduleProtocol.h"

@interface BUSessionView : UIView <BUScheduleProtocol>

@property (weak, nonatomic) id dataSource;
@property (weak, nonatomic) id  delegate;

@end
