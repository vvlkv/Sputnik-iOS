//
//  BUMainStateModel.h
//  SUAI_Navigation
//
//  Created by Виктор on 09.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUMainStateModel;
@protocol BUMainStateModelDelegate <NSObject>

@required
- (void)resetStateToDefault:(BUMainStateModel *)stateModel;
- (void)stateModel:(BUMainStateModel *)stateModel showAuditory:(NSString *)auditory;
- (void)stateModel:(BUMainStateModel *)stateModel showPathFrom:(NSString *)from to:(NSString *)to;
- (void)showAlertController;

@end

@interface BUMainStateModel : NSObject

@property (weak, nonatomic) id <BUMainStateModelDelegate> delegate;

- (NSArray *)auditories;

- (void)setAuditory:(NSString *)auditory forDirection:(NSUInteger)direction;
- (void)resetAuditoryForDirection:(NSUInteger)direction;
- (void)revertAuditories;
- (void)prepareToExecute;
- (void)showNormalPath;

@end
