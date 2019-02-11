//
//  UIButton+Com.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/11.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COMMON_HEIGHT 50

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Com)

+ (UIButton *)initWithFrame:(CGRect)rect title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
