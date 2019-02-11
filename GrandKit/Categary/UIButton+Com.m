//
//  UIButton+Com.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/11.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "UIButton+Com.h"

@implementation UIButton (Com)

+ (UIButton *)initWithFrame:(CGRect)rect title:(NSString *)title {
    UIButton *btn = [[UIButton alloc]initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [btn.layer setBorderWidth:2.0];
    return btn;
}

@end
