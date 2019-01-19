//
//  UIImage+Com.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/19.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "UIImage+Com.h"

@implementation UIImage (Com) // 分类-Category  待扩展的类（分类的名称）


+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}

@end
