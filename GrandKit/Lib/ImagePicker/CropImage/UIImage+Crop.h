//
//  UIImage+Crop.h
//  GrandKit
//
//  Created by Evan Fang on 2019/4/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

/**
 缩放指定大小
 
 @param newSize 缩放后的尺寸
 @return UIImage
 */
- (UIImage *)resizeImageWithSize:(CGSize)newSize;

/**
 图片圆形裁剪
 
 @return UIImage
 */
- (UIImage *)ovalClip;
@end
