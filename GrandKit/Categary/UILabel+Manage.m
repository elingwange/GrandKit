//
//  UILabel+Manage.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "UILabel+Manage.h"

@implementation UILabel (Manage)

+ (UILabel *)creatWithTextColor:(UIColor *)color font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    return label;
}

@end
