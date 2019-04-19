//
//  EFImagePickerViewController2.m
//  GrandKit
//
//  Created by Evan Fang on 2019/4/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "EFImagePickerViewController2.h"
#import "CropImageController.h"
#import "UIImage+Crop.h"

@interface EFImagePickerViewController2 () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UIImagePickerController * pickerController;

@end

@implementation EFImagePickerViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"头像";
    
    self.headButton = [[UIButton alloc]initWithFrame:CGRectMake((Width - Size(120)) / 2, Size(80), Size(120), Size(120))];
    [self.headButton setTitle:@"选择头像" forState:UIControlStateNormal];
    [self.headButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headButton];
}

- (void)btnClick:(UIButton *)sender {
    
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction * camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [ac addAction:camera];
    }
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:photo];
    [ac addAction:cancel];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CropImageController * con = [[CropImageController alloc] initWithImage:image delegate:self];
        [self.navigationController pushViewController:con animated:YES];
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = image.size.height * (width/image.size.width);
    UIImage *orImage = [image resizeImageWithSize:CGSizeMake(width, height)];
    CropImageController *con = [[CropImageController alloc] initWithImage:orImage delegate:self];
    con.ovalClip = YES;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark -- CropImageDelegate
- (void)cropImageDidFinishedWithImage:(UIImage *)image {
    [_headButton setBackgroundImage:image forState:UIControlStateNormal];
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
@end

