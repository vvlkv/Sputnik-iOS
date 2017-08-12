//
//  BUNavigationPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationPresenter.h"
#import "BUNavigationPresenterState.h"
#import "NSString+Dash.h"
#import "BUMainStateModel.h"

@class UIViewController;
@interface BUNavigationPresenter () <BUMainStateModelDelegate> {
    BUNavigationPresenterState *state;
    BUMainStateModel *stateModel;
}

@end

@implementation BUNavigationPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = [[BUNavigationPresenterState alloc] init];
        stateModel = [[BUMainStateModel alloc] init];
        stateModel.delegate = self;
    }
    return self;
}


#pragma mark - BUNavigationRouterOutput

- (void)didScannedCode:(NSString *)code {
    [self parseUrlWithString:code];
}

- (void)didFoundAuditory:(NSString *)auditory {
    [stateModel setAuditory:auditory forDirection:state.findingAuditoryIndex];
    [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
}


#pragma mark - BUMainScreenViewControllerOutput

- (void)didWebViewLoaded {
    
}

- (void)didButtonPressed:(NSUInteger)index {
    state.findingAuditoryIndex = index;
    [self.router presentSearchViewControllerFromViewController:(UIViewController *)self.view andPresenter:self];
}

- (void)didCancelButtonPressed:(NSUInteger)index {
    [stateModel resetAuditoryForDirection:index];
    [stateModel prepareToExecute];
}

- (void)didCameraButtonPressed {
    [self.router presentCameraViewControllerFromViewController:(UIViewController *)self.view andPresenter:self];
}

- (void)didArrowPressed {
    NSArray *auditories = [stateModel auditories];
    if (![auditories containsObject:@""]) {
        [self.view setContent:auditories[0] forButtonAtIndex:1];
        [self.view setContent:auditories[1] forButtonAtIndex:0];
        [self.view startAnimating];
        [self performSelector:@selector(invert) withObject:nil afterDelay:0.001];
    }
}

- (void)invert {
    if ([stateModel revertAuditories]) {
        [stateModel prepareToExecute];
        [self.view stopAnimating];
    }
}

- (void)didWebViewLoadedWithCode:(NSInteger)code {
    if (code > 0) {
        state.auditories[state.findingAuditoryIndex] = state.tryingAuditory;
        [self.view setContent:state.tryingAuditory forButtonAtIndex:state.findingAuditoryIndex];
    }
}

- (void)didReceivedAuditory:(NSString *)auditory {
    NSString *aud = [NSString deleteDash:[[auditory componentsSeparatedByString:@" "] lastObject]];
    if ([aud isEqualToString:@""]) {
        [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                              message:@"У нас пока что есть навигация только для БМ"
                            andAction:@"Обидно"];
    }
    [stateModel setAuditory:aud forDirection:0];
    state.findingAuditoryIndex = 0;
    [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
}

#pragma mark - BUMainStateModelDelegate

- (void)resetStateToDefault:(BUMainStateModel *)stateModel {
    [self.view showStartScreen];
}

- (NSInteger)stateModel:(BUMainStateModel *)stateModel showAuditory:(NSString *)auditory {
    NSInteger errCode = [self.view showAuditory:auditory];
    if (errCode < 0) {
        [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                              message:@"Попробуйте найти аудиторию рядом"
                            andAction:@"Попробовать"];
    } else {
        [self.view setContent:auditory forButtonAtIndex:state.findingAuditoryIndex];
    }
    return errCode;
}

- (void)stateModel:(BUMainStateModel *)stateModel showPathFrom:(NSString *)from to:(NSString *)to {
    [self.view showPathFrom:from
                         to:to];
    [self.view setContent:from forButtonAtIndex:0];
    [self.view setContent:to forButtonAtIndex:1];
}

- (void)showAlertController {
    [self performSelector:@selector(showNormalAlertController) withObject:nil afterDelay:0.3];
}

- (void)showNormalAlertController {
    [self.view showNormalAlert];
}

- (void)didNormalRouteSelected {
    [stateModel showNormalPath];
}

- (void)execute {
    [stateModel prepareToExecute];
    [self.view stopAnimating];
}

- (void)parseUrlWithString:(NSString *)url {
    if (![url containsString:@"purecreation"]) {
        [self.view showAlertWithTitle:@"Некорректная ссылка :("
                              message:@"QR-код не содержит информации об аудитории"
                            andAction:@"Обидно"];
        return;
    }
    NSArray *result = [url componentsSeparatedByString:@"&&"];
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    for (int i = 0; i < [result count]; i++) {
        [paths addObject: [[result[i] componentsSeparatedByString:@"="] lastObject]];
    }
    
    if ([paths count] == 1) {
        NSInteger errCode = [self.view showAuditory:paths[0]];
        if (errCode < 0) {
            [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                                  message:@"Попробуйте найти аудиторию рядом"
                                andAction:@"Попробовать"];
        } else {
            [stateModel setAuditory:paths[0] forDirection:0];
            [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
        }
    } else if ([paths count] == 2) {
        [stateModel setPathFrom:paths[0] to:paths[1]];
        [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
    }
}

@end
