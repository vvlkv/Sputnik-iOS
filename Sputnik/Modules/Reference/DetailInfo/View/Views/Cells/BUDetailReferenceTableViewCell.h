//
//  BUDetailReferenceTableViewCell.h
//  SUAI_Navigation
//
//  Created by Виктор on 17/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUReferenceViewModelItemProtocol.h"

@interface BUDetailReferenceTableViewCell : UITableViewCell

@property (strong, nonatomic) id <BUReferenceViewModelItemProtocol> model;

@end
