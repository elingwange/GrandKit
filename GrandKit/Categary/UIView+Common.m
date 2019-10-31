//
//  UIView+Common.m
//  GrandKit
//
//  Created by Evan on 2019/9/17.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)


- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
