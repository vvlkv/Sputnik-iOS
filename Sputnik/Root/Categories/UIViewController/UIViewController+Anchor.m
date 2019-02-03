//
//  UIViewController+Anchor.m
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "UIViewController+Anchor.h"

@implementation UIViewController (Anchor)

- (NSLayoutYAxisAnchor *)topAnchor {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.topAnchor;
    }
    return self.topLayoutGuide.bottomAnchor;
}
- (NSLayoutYAxisAnchor *)bottomAnchor {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.bottomAnchor;
    }
    return self.bottomLayoutGuide.topAnchor;
}

- (NSLayoutXAxisAnchor *)leftAnchor {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.leftAnchor;
    }
    return self.view.leftAnchor;
}

- (NSLayoutXAxisAnchor *)rightAnchor {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.rightAnchor;
    }
    return self.view.rightAnchor;
}

@end
