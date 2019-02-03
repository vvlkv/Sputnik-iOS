//
//  SUAIPageControl.h
//  PageViewControllerTest
//
//  Created by Виктор on 16/12/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SUAIPageControl;
@protocol SUAIPageControlDelegate <NSObject>
@required
-(void)pageControl:(SUAIPageControl *)pageControl didTapOnSectionAtIndex:(NSUInteger)index;

@end

@interface SUAIPageControl : UIView

@property (assign, nonatomic) NSUInteger currentPage;
@property (weak, nonatomic) id<SUAIPageControlDelegate> delegate;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles startIndex:(NSUInteger)index;

- (void)fillMarkers:(NSArray *)markers;

@end

NS_ASSUME_NONNULL_END
