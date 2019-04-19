//
//  EFImageClipViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/4/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "EFImageClipController.h"
#import "DNTapDetectingImageView.h"

#import "UIView+DNImagePicker.h"
#import "DNImagePickerHelper.h"

@interface EFImageClipController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *zoomingScrollView;
@property (nonatomic, strong) DNTapDetectingImageView *photoImageView;
@end

@implementation EFImageClipController


#pragma mark - ==============  setter  ==============
- (void)setAsset:(DNAsset *)asset {
    if (_asset != asset) {
        _asset = asset;
        [self displayImage];
    }
}

- (DNTapDetectingImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[DNTapDetectingImageView alloc] initWithFrame:CGRectZero];
//        _photoImageView.tapDelegate = self;
        _photoImageView.contentMode = UIViewContentModeCenter;
        _photoImageView.backgroundColor = [UIColor blackColor];
        [self.zoomingScrollView addSubview:_photoImageView];
    }
    return _photoImageView;
}

- (UIScrollView *)zoomingScrollView {
    if (!_zoomingScrollView) {
        _zoomingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Size(20), self.view.frame.size.width, self.view.frame.size.height - Size(40))];
        _zoomingScrollView.delegate = self;
        _zoomingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
        _zoomingScrollView.showsHorizontalScrollIndicator = NO;
        _zoomingScrollView.showsVerticalScrollIndicator = NO;
        _zoomingScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        [self.view addSubview:_zoomingScrollView];
    }
    return _zoomingScrollView;
}

#pragma mark - ==============  lifecycle  ==============

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewWhenLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initViewWhenAppear];
    
    [self initDataWhenAppear];
}

#pragma mark - ==============  init methods  ==============

- (void)initViewWhenLoad {
    self.title = @"保存";
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)initViewWhenAppear {
    
}

- (void)initDataWhenAppear {
    
}

/*
 Get and display image
 */
- (void)displayImage {
    self.zoomingScrollView.maximumZoomScale = 1;
    self.zoomingScrollView.minimumZoomScale = 1;
    self.zoomingScrollView.zoomScale = 1;
    self.zoomingScrollView.contentSize = CGSizeMake(0, 0);
    __weak typeof(self)weakSelf = self;
    [DNImagePickerHelper fetchImageWithAsset:self.asset targetSize:self.zoomingScrollView.size needHighQuality:YES imageResutHandler:^(UIImage * _Nonnull image) {
        if (!image) {
            return;
        }
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.photoImageView.image = image;
        strongSelf.photoImageView.hidden = NO;
        CGRect photoImageViewFrame;
        photoImageViewFrame.origin = CGPointZero;
        photoImageViewFrame.size = image.size;
        strongSelf.photoImageView.frame = photoImageViewFrame;
        strongSelf.zoomingScrollView.contentSize = photoImageViewFrame.size;
        
        // Set zoom to minimum zoom
        [strongSelf setMaxMinZoomScalesForCurrentBounds];
        [strongSelf.view setNeedsLayout];
    }];
}

#pragma mark - ==============  UIScrollViewDelegate  ==============
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.photoImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.zoomingScrollView.scrollEnabled = YES; // reset
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

#pragma mark - Setup
- (CGFloat)initialZoomScaleWithMinScale {
    CGFloat zoomScale = self.zoomingScrollView.minimumZoomScale;
    // Zoom image to fill if the aspect ratios are fairly similar
    CGSize boundsSize = self.zoomingScrollView.bounds.size;
    CGSize imageSize = self.photoImageView.image.size;
    CGFloat boundsAR = boundsSize.width / boundsSize.height;
    CGFloat imageAR = imageSize.width / imageSize.height;
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    // Zooms standard portrait images on a 3.5in screen but not on a 4in screen.
    if (ABS(boundsAR - imageAR) < 0.17) {
        zoomScale = MAX(xScale, yScale);
        // Ensure we don't zoom in or out too far, just in case
        zoomScale = MIN(MAX(self.zoomingScrollView.minimumZoomScale, zoomScale), self.zoomingScrollView.maximumZoomScale);
    }
    return zoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    // Reset
    self.zoomingScrollView.maximumZoomScale = 1;
    self.zoomingScrollView.minimumZoomScale = 1;
    self.zoomingScrollView.zoomScale = 1;
    
    // Bail if no image
    if (!_photoImageView.image) return;
    
    // Reset position
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
    
    // Sizes
    CGSize boundsSize = self.zoomingScrollView.bounds.size;
    CGSize imageSize = _photoImageView.image.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // Calculate Max
    CGFloat maxScale = 1.5;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Let them go a bit bigger on a bigger screen!
        maxScale = 4;
    }
    
    // Image is smaller than screen so no zooming!
    if (xScale >= 1 && yScale >= 1) {
        minScale = 1.0;
    }
    
    // Set min/max zoom
    self.zoomingScrollView.maximumZoomScale = maxScale;
    self.zoomingScrollView.minimumZoomScale = minScale;
    
    // Initial zoom
    self.zoomingScrollView.zoomScale = [self initialZoomScaleWithMinScale];
    
    // If we're zooming to fill then centralise
    if (self.zoomingScrollView.zoomScale != minScale) {
        // Centralise
        self.zoomingScrollView.contentOffset = CGPointMake((imageSize.width * self.zoomingScrollView.zoomScale - boundsSize.width) / 2.0,
                                                           (imageSize.height * self.zoomingScrollView.zoomScale - boundsSize.height) / 2.0);
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.zoomingScrollView.scrollEnabled = NO;
    }
    
    // Layout
    [self.view setNeedsLayout];
    
}
@end
