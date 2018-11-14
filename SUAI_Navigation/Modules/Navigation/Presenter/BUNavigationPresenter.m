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
//    BUNavigationPresenterState *state;
//    BUMainStateModel *stateModel;
}

@property (strong, nonatomic) BUNavigationPresenterState *state;
@property (strong, nonatomic) BUMainStateModel *stateModel;

@end

@implementation BUNavigationPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateModel = [[BUMainStateModel alloc] init];
        self.stateModel.delegate = self;
        self.state = [[BUNavigationPresenterState alloc] init];
        self.state.isMapLoaded = NO;
        self.state.temporaryAuditory = @"";
    }
    return self;
}


#pragma mark - BUNavigationRouterOutput

- (void)didScannedCode:(NSString *)code {
    [self parseUrlWithString:code];
}

- (void)didFoundAuditory:(NSString *)auditory {
    [self.stateModel setAuditory:auditory forDirection:self.state.findingAuditoryIndex];
    [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
}


#pragma mark - BUMainScreenViewControllerOutput

- (void)didWebViewLoaded {
    self.state.isMapLoaded = YES;
    if (![self.state.temporaryAuditory isEqualToString:@""]) {
        [self showTemporaryAuditory];
    }
}

- (void)didButtonPressed:(NSUInteger)index {
    self.state.findingAuditoryIndex = index;
    [self.router presentSearchViewControllerFromViewController:(UIViewController *)self.view andPresenter:self];
}

- (void)didCancelButtonPressed:(NSUInteger)index {
    [self.stateModel resetAuditoryForDirection:index];
    [self.stateModel prepareToExecute];
}

- (void)didCameraButtonPressed {
    [self.router presentCameraViewControllerFromViewController:(UIViewController *)self.view andPresenter:self];
}

- (void)didArrowPressed {
    NSArray *auditories = [self.stateModel auditories];
    if (![auditories containsObject:@""]) {
        [self.view setContent:auditories[0] forButtonAtIndex:1];
        [self.view setContent:auditories[1] forButtonAtIndex:0];
        [self.view startAnimating];
        [self performSelector:@selector(invert) withObject:nil afterDelay:0.001];
    }
}

- (void)invert {
    if ([self.stateModel revertAuditories]) {
        [self.stateModel prepareToExecute];
        [self.view stopAnimating];
    }
}

- (void)didWebViewLoadedWithCode:(NSInteger)code {
    if (code > 0) {
        self.state.auditories[self.state.findingAuditoryIndex] = self.state.tryingAuditory;
        [self.view setContent:self.state.tryingAuditory forButtonAtIndex:self.state.findingAuditoryIndex];
    }
}

- (void)didReceivedAuditory:(NSString *)auditory {
    
    NSString *aud = [NSString prepareAuditoryToLoad:auditory];
    if ([aud isEqualToString:@""]) {
        [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                              message:@"У нас пока что есть навигация только для Б.М."
                            andAction:@"Обидно"];
    } else {
        if (self.state.isMapLoaded) {
            self.state.findingAuditoryIndex = 1;
            [self.stateModel setAuditory:aud forDirection:self.state.findingAuditoryIndex];
            [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
        } else {
            self.state.temporaryAuditory = aud;
        }
    }
}

- (void)showTemporaryAuditory {
    self.state.findingAuditoryIndex = 1;
    [self.stateModel setAuditory:self.state.temporaryAuditory forDirection:self.state.findingAuditoryIndex];
    [self performSelector:@selector(execute) withObject:nil afterDelay:1];
}

#pragma mark - BUMainStateModelDelegate

- (void)resetStateToDefault:(BUMainStateModel *)stateModel {
    [self.view showStartScreen];
}

//- (NSInteger)stateModel:(BUMainStateModel *)stateModel showAuditory:(NSString *)auditory {
//    __weak typeof(self) welf = self;
//    [self.view showAuditory:auditory errCode:^(NSInteger code) {
//        if (code < 0) {
//            [welf.view showAlertWithTitle:@"Простите, аудитория не найдена :("
//                                  message:@"Попробуйте найти аудиторию рядом"
//                                andAction:@"Попробовать"];
//        } else {
//            [welf.view setContent:auditory forButtonAtIndex:welf.state.findingAuditoryIndex];
//        }
//    }];
////    NSInteger errCode = [self.view showAuditory:auditory];
////    if (errCode < 0) {
////        [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
////                              message:@"Попробуйте найти аудиторию рядом"
////                            andAction:@"Попробовать"];
////    } else {
////        [self.view setContent:auditory forButtonAtIndex:state.findingAuditoryIndex];
////    }
//    return errCode;
//}

- (void)stateModel:(BUMainStateModel *)stateModel
      showAuditory:(NSString *)auditory
       withErrCode:(void (^)(NSInteger))retBlock {
    
    __weak typeof(self) welf = self;
    [self.view showAuditory:auditory errCode:^(NSInteger code) {
        if (code < 0) {
            [welf.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                                  message:@"Попробуйте найти аудиторию рядом"
                                andAction:@"Попробовать"];
        } else {
            [welf.view setContent:auditory forButtonAtIndex:welf.state.findingAuditoryIndex];
        }
        retBlock(code);
    }];
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
    [self.stateModel showNormalPath];
}

- (void)execute {
    [self.stateModel prepareToExecute];
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
        __weak typeof(self) welf = self;
        [self.view showAuditory:paths[0] errCode:^(NSInteger code) {
            if (code < 0) {
                [self.view showAlertWithTitle:@"Простите, аудитория не найдена :("
                                      message:@"Попробуйте найти аудиторию рядом"
                                    andAction:@"Попробовать"];
            } else {
                [welf.stateModel setAuditory:paths[0] forDirection:0];
                [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
            }
        }];
    } else if ([paths count] == 2) {
        [self.stateModel setPathFrom:paths[0] to:paths[1]];
        [self performSelector:@selector(execute) withObject:nil afterDelay:0.01];
    }
}

@end
