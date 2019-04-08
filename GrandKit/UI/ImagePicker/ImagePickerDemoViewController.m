//
//  ImagePickerDemoViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/4/8.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "ImagePickerDemoViewController.h"
#import "EFImagePickerController.h"

@interface ImagePickerDemoViewController ()

@property (nonatomic, strong) UIButton *btnSelectImage;
@property (nonatomic, strong) UIImageView *ivImage;

@end


@implementation ImagePickerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ImagePicker";
    
    _btnSelectImage = [[UIButton alloc]initWithFrame:CGRectMake(PADDING, PADDING, Width - Size(40), Size(50))];
    [_btnSelectImage setTitle:@"选择图片" forState:UIControlStateNormal];
    _btnSelectImage.backgroundColor = [UIColor lightGrayColor];
    _btnSelectImage.layer.cornerRadius = Size(5);
    [_btnSelectImage addTarget:self action:@selector(onSelectImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSelectImage];
}

-(void)onSelectImage {
    EFImagePickerController *vc = [EFImagePickerController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
