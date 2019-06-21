//
//  BUReferenceDetailInfoPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoPresenter.h"
#import "BUReferenceDetailInfoDataDisplayManager.h"
#import "BUReferenceMainScreenRouterInput.h"
#import "BUReferenceDetailInfoViewControllerInput.h"
#import "BUReferenceDetailInfoInteractorInput.h"
#import "BUReferenceDetailInfoAction.h"
#import "NSString+Dash.h"

@interface BUReferenceDetailInfoPresenter () {
    BUReferenceDetailInfoDataDisplayManager *dataManager;
    BUReferenceDetailInfoAction *action;
}

@end

@implementation BUReferenceDetailInfoPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        action = [[BUReferenceDetailInfoAction alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    
}

- (id <BUReferenceTableViewDataSource>)dataSource {
    return dataManager;
}

- (void)didPressOnEntityAdIndex:(NSUInteger)index {
    [self.input prepareEntityToShowDataAtIndex:index];
}

- (void)didPressOnAbout {
    [self.input prepareDataToAboutInfo];
}

- (void)didPerformActionWithItem:(id <BUReferenceViewModelItemProtocol>)item {
    action.value = [item value];
    action.type = [item actionType];
    [self didPressOnAction];
}

- (void)didPressOnAction {
    switch ([action type]) {
        case ReferenceActionTypeCall:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [NSString prepareToCall:[action value]]]] options:@{} completionHandler:nil];
            break;
        case ReferenceActionTypeMail:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", [action value]]] options:@{} completionHandler:nil];
            break;
        case ReferenceActionTypeSite:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[action value]] options:@{} completionHandler:nil];
            break;
        case ReferenceActionTypeAuditory:
            [self.router viewController:(UIViewController *)self.view foundAuditory:[action value]];
            break;
        default:
            break;
    }
}

#pragma mark - BUReferenceDetailInfoInteractorOutput

- (void)didObtainDataViewModel:(NSArray *)dataViewModels {
    dataManager = [[BUReferenceDetailInfoDataDisplayManager alloc] initWithEntities:dataViewModels];
    [self.view reloadData];
}

- (void)didPrepareDataToShow:(id)model {
    [self.router presentDetailInfoViewControllerWithEntity:model fromViewController:(UIViewController *)self.view];
}

@end
