//
//  BUReferenceMainScreenPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceMainScreenPresenter.h"
#import "BUReferenceDataDisplayManager.h"
#import "BUReferenceSearcher.h"

@class UIViewController;
@interface BUReferenceMainScreenPresenter() <BUReferenceDataDisplayManagerDelegate> {
    NSArray *referenceInfo;
    BUReferenceDataDisplayManager *dataManager;
    BUReferenceSearcher *searcher;
}

@end

@implementation BUReferenceMainScreenPresenter


#pragma mark - BUReferenceViewControllerOutput

- (void)didPressSegmentController:(NSUInteger)index {
    [dataManager activeReference:index];
    [self.view updateTableView];
}

- (void)didEnterSearchText:(NSString *)searchText {
    [searcher searchEntitiesWithSearchText:searchText];
    [self.view updateSearchTableView];
}

- (id <BUReferenceMainScreenContentDataSource>)dataSource {
    return dataManager;
}

- (id <BUReferenceMainScreenContentDelegate>)delegate {
    return dataManager;
}

- (id<BUReferenceMainScreenContentDataSource>)searchDataSource {
    return searcher;
}

- (id<BUReferenceMainScreenContentDelegate>)searchDelegate {
    return searcher;
}

#pragma mark - BUreferenceMainScreenInteractorOutput

- (void)didLoadReference:(NSArray *)reference {
    dataManager = [[BUReferenceDataDisplayManager alloc] initWithReference:reference];
    dataManager.delegate = self;
    searcher = [[BUReferenceSearcher alloc] initWithReference:reference];
    searcher.delegate = self;
    [self.view updateTableView];
}


#pragma mark - BUReferenceDataDisplayManagerDelegate

- (void)pushDetailInfoWithEntity:(id)entity {
    [self.router presentDetailInfoViewControllerWithEntity:entity fromViewController:(UIViewController*)self.view];
}

@end
