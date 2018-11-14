//
//  UIView+MenuItemIndicatorBuilder.m
//  SUAI_Navigation
//
//  Created by Виктор on 02.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "UIView+MenuItemIndicatorBuilder.h"
#import "UIColor+SUAI.h"
#import "BUIndicatorView.h"

@implementation UIView (MenuItemIndicatorBuilder)

+ (UIView *)createIndicatorForWeekOfType:(WeekType)weekType {
//    UIView *indicatorViewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//
//    BUIndicatorView *topView = [[BUIndicatorView alloc] initWithFrame:CGRectMake(0, 0, indicatorViewBackground.frame.size.width, indicatorViewBackground.frame.size.height/2)
//                                                      andRoundCorners:UIRectCornerTopRight | UIRectCornerTopLeft];
//
//    BUIndicatorView *bottomView = [[BUIndicatorView alloc] initWithFrame:CGRectMake(0, indicatorViewBackground.frame.size.height/2, indicatorViewBackground.frame.size.width, indicatorViewBackground.frame.size.height/2)
//                                                         andRoundCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
//
//    bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
//    topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
//    [indicatorViewBackground addSubview:topView];
//    [indicatorViewBackground addSubview:bottomView];
//
//    switch (weekType) {
//        case WeekTypeRed: {
//            topView.backgroundColor = [UIColor suaiRedColor];
//            bottomView.backgroundColor = [UIColor suaiRedColor];
//            break;
//        }
//        case WeekTypeBlue: {
//            topView.backgroundColor = [UIColor suaiBlueColor];
//            bottomView.backgroundColor = [UIColor suaiBlueColor];
//            break;
//        }
//        case WeekTypeBoth: {
//            topView.backgroundColor = [UIColor suaiRedColor];
//            bottomView.backgroundColor = [UIColor suaiBlueColor];
//            break;
//        }
//        default:
//            break;
//    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    view.layer.cornerRadius = 4.f;
    view.autoresizesSubviews = YES;
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    top.backgroundColor = [UIColor suaiRedColor];
    top.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
    bottom.backgroundColor = [UIColor suaiBlueColor];
    bottom.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    [view addSubview:top];
    [view addSubview:bottom];
    view.clipsToBounds = YES;
    return view;
}

@end
