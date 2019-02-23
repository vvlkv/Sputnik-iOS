//
//  SUAIPageViewController.m
//  PageViewControllerTest
//
//  Created by Виктор on 15/12/2018.
//  Copyright © 2018 Victor. All rights reserved.
//

#import "SUAIPageViewController.h"
#import "SUAIPageControl.h"
#define SCROLL
@interface SUAIPageViewController () <UIPageViewControllerDelegate, SUAIPageControlDelegate, UIScrollViewDelegate> {
    NSArray <__kindof UIViewController *> *_viewControllers;
    NSUInteger activeIndex;
    UIScrollView *scrollView;
}

@property (strong, nonatomic) UIPageViewController *pageViewControler;
@property (strong, nonatomic) SUAIPageControl      *pageControl;

@end

NSUInteger const pageHeight = 34;

@implementation SUAIPageViewController

-(instancetype)initWithViewControllers:(NSArray <__kindof UIViewController *> *)viewControllers {
    return [self initWithViewControllers:viewControllers activeAtIndex:0];
}

-(instancetype)initWithViewControllers:(NSArray <__kindof UIViewController *> *)viewControllers
                         activeAtIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _viewControllers = viewControllers;
        activeIndex = index;
    }
    return self;
}

- (void)updateMarkers:(NSArray *)markers {
    [_pageControl fillMarkers:markers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurePageControl];
    [self configurePageViewController];
}

- (void)configurePageControl {
    NSMutableArray<NSString *> *titles = [NSMutableArray arrayWithCapacity:[_viewControllers count]];
    for (UIViewController *title in _viewControllers) {
        [titles addObject:title.title];
    }
    _pageControl = [[SUAIPageControl alloc] initWithTitles:titles
                                                startIndex:activeIndex];
    _pageControl.delegate = self;
    CGSize viewSize = self.view.frame.size;
    _pageControl.frame = CGRectMake(0, 0, viewSize.width, pageHeight);
    _pageControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageControl];
}

- (void)configurePageViewController {
#ifdef SCROLL
    scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    CGRect activeRect = CGRectZero;
    for (int i = 0; i < [_viewControllers count]; i++) {
        UIViewController *viewController = _viewControllers[i];
        viewController.view.frame = CGRectMake(i * self.view.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        [scrollView addSubview:viewController.view];
        if (i == activeIndex)
            activeRect = viewController.view.frame;
    }
    [self.view addSubview:scrollView];
    [[scrollView.topAnchor constraintEqualToAnchor:_pageControl.bottomAnchor] setActive:YES];
    [[scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * [_viewControllers count], scrollView.bounds.size.height);
    [scrollView setContentOffset:activeRect.origin animated:YES];
#else
    _pageViewControler = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                       options:nil];
    _pageViewControler.view.frame = CGRectMake(0, pageHeight, self.view.bounds.size.width, self.view.bounds.size.height - pageHeight);
    _pageViewControler.delegate = self;
    _pageViewControler.dataSource = self;
    [_pageViewControler setViewControllers:@[_viewControllers[activeIndex]]
                                 direction:UIPageViewControllerNavigationDirectionReverse
                                  animated:NO
                                completion:nil];
    [self addChildViewController:_pageViewControler];
    [self.view addSubview:_pageViewControler.view];
    [_pageViewControler didMoveToParentViewController:self];
#endif
}

#ifndef SCROLL
#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    activeIndex = [_viewControllers indexOfObject:pendingViewControllers.firstObject];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _pageControl.currentPage = activeIndex;
    }
}


#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    index--;
    return _viewControllers[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    index++;
    if (index == [_viewControllers count]) {
        return nil;
    }
    return _viewControllers[index];
}

#endif

#pragma mark - SUAIPageControlDelegate

- (void)pageControl:(SUAIPageControl *)pageControl didTapOnSectionAtIndex:(NSUInteger)index {
#ifndef SCROLL
    UIPageViewControllerNavigationDirection direction = index > lastTappedIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    lastTappedIndex = index;
    [_pageViewControler setViewControllers:@[_viewControllers[index]]
                                 direction:direction
                                  animated:true completion:nil];
#else
    CGRect scrollToRect = CGRectMake(scrollView.frame.size.width * index, 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds));
    [scrollView setContentOffset:scrollToRect.origin animated:YES];
#endif
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.offset = scrollView.contentOffset.x;
}

@end
