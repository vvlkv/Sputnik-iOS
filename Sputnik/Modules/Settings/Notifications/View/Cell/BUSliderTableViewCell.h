//
//  BUSliderTableViewCell.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUSliderTableViewCell : UITableViewCell

@property (nonatomic, assign) NSUInteger sliderValue;
@property (nonatomic, strong) NSString *titleValue;

@end

NS_ASSUME_NONNULL_END
