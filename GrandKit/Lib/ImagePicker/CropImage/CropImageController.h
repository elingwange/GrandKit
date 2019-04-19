//
//  CropImageController.h
//  GrandKit
//
//  Created by Evan Fang on 2019/4/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

@protocol CropImageDelegate <NSObject>
- (void)cropImageDidFinishedWithImage:(UIImage *)image;
@end

@interface CropImageController : EFBaseViewController

@property (nonatomic, weak) id <CropImageDelegate> delegate;
//圆形裁剪，默认NO;
@property (nonatomic, assign) BOOL ovalClip;

- (instancetype)initWithImage:(UIImage *)originalImage delegate:(id)delegate;

@end
