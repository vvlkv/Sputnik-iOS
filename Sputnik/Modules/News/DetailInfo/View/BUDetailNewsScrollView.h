//
//  BUDetailNewsView.h
//  Sputnik
//
//  Created by Виктор on 22/03/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDetailNewsScrollView : UIView

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *subHeader;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIImage *image;

@end

NS_ASSUME_NONNULL_END
