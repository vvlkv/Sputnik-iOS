//
//  BUPanelMapView.h
//  SPutnikButtons
//
//  Created by Виктор on 24/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUPanelMapView;
@protocol BUPanelMapViewDelegate <NSObject>

@required
- (void)panelView:(BUPanelMapView *)panelView didPressOnButtonWithTag:(NSUInteger)tag;

@end


@interface BUPanelMapView : UIView

@property (weak, nonatomic) id <BUPanelMapViewDelegate> delegate;

@end
