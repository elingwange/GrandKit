//
//  EFImagePickerController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/4/8.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "EFImagePickerController.h"

#import "UIViewController+DNImagePicker.h"
#import "UIView+DNImagePicker.h"
#import "DNAssetsViewCell.h"
#import "DNImagePickerHelper.h"
#import "DNAlbum.h"
#import "DNAsset.h"


@interface EFImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate, DNAssetsViewCellDelegate>

@property (nonatomic, strong) DNAlbum *album;
@property (nonatomic, copy) NSString *albumIdentifier;

@property (nonatomic, strong) UICollectionView *imageFlowCollectionView;
@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

static NSString* const dnAssetsViewCellReuseIdentifier = @"DNAssetsViewCell";

@implementation EFImagePickerController


- (instancetype)initWithAlbumIdentifier:(NSString *)albumIdentifier {
    self = [super init];
    if (self) {
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _albumIdentifier = albumIdentifier;
    }
    return self;
}

- (instancetype)initWithAblum:(DNAlbum *)album {
    self = [super init];
    if (self) {
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _album = album;
    }
    return self;
}

#pragma mark - getter/setter

- (UICollectionView *)imageFlowCollectionView {
    if (!_imageFlowCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _imageFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        [_imageFlowCollectionView registerClass:[DNAssetsViewCell class] forCellWithReuseIdentifier:dnAssetsViewCellReuseIdentifier];
        _imageFlowCollectionView.backgroundColor = [UIColor clearColor];
        _imageFlowCollectionView.alwaysBounceVertical = YES;
        _imageFlowCollectionView.delegate = self;
        _imageFlowCollectionView.dataSource = self;
        _imageFlowCollectionView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:_imageFlowCollectionView];
    }
    return _imageFlowCollectionView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.centerX = CGRectGetWidth(self.view.bounds) / 2;
        _indicatorView.centerY = CGRectGetHeight(self.view.bounds) / 2;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择图片";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupView];
    
    [self setupData];
}

- (void)setupView {
    
    [self initWithAblum:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBarButtonItemAtPosition:DNImagePickerNavigationBarPositionRight
                                   text:@"保存"
                                 action:@selector(saveAction)];
    [self imageFlowCollectionView];
}

/*
 加载相册图片
 默认选择全部图片
 */
- (void)setupData {
    [self.indicatorView startAnimating];
    __weak typeof(self) wSelf = self;
    [DNImagePickerHelper requestAlbumListWithCompleteHandler:^(NSArray<DNAlbum *> * _Nonnull albumList) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (albumList) {

            for (DNAlbum *album in albumList) {
                NSString *name = album.albumTitle;
                NSLog(@"%@", name);
            }

            [self.indicatorView stopAnimating];

            sSelf.album = [albumList copy][0];
            sSelf.title = sSelf.album.albumTitle;
            [sSelf loadData];
        }
    }];
}

- (void)loadData {
    if (!self.assetsArray.count) {
        [self.indicatorView startAnimating];
    }
    __weak typeof(self) wSelf = self;
    [DNImagePickerHelper fetchImageAssetsInAlbum:self.album completeHandler:^(NSArray<DNAsset *> * imageArray) {
        __strong typeof(wSelf) sSelf = wSelf;
        [sSelf.indicatorView stopAnimating];
        [sSelf.assetsArray removeAllObjects];
        [sSelf.assetsArray addObjectsFromArray:imageArray];
        [self.imageFlowCollectionView reloadData];
//        [self scrollerToBottom:NO];
    }];
}

#pragma mark - helpmethods
- (void)scrollerToBottom:(BOOL)animated {
    NSInteger rows = [self.imageFlowCollectionView numberOfItemsInSection:0] - 1;
    [self.imageFlowCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:rows inSection:0]
                                         atScrollPosition:UICollectionViewScrollPositionBottom
                                                 animated:animated];
}

#pragma mark - DNAssetsViewCellDelegate
- (void)didSelectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell {
    assetsCell.isSelected = [self seletedAssets:assetsCell.asset];
}

- (void)didDeselectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell {
    assetsCell.isSelected = NO;
    [self deseletedAssets:assetsCell.asset];
}

#pragma mark - UICollectionView delegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DNAssetsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dnAssetsViewCellReuseIdentifier forIndexPath:indexPath];
    DNAsset *asset = self.assetsArray[indexPath.row];
    cell.delegate = self;
    [cell fillWithAsset:asset isSelected:[self.selectedAssetsArray containsObject:asset]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self browserPhotoAsstes:self.assetsArray pageIndex:indexPath.row];
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - priviate methods

- (BOOL)seletedAssets:(DNAsset *)asset {
//    if ([self.selectedAssetsArray containsObject:asset]) {
//        return NO;
//    }
//    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
//    firstItem.enabled = YES;
//    if (self.selectedAssetsArray.count >= kDNImageFlowMaxSeletedNumber) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"alertTitle", @"DNImagePicker", nil)
//                                                        message:NSLocalizedStringFromTable(@"alertContent", @"DNImagePicker", nil)
//                                                       delegate:self
//                                              cancelButtonTitle:NSLocalizedStringFromTable(@"alertButton", @"DNImagePicker", nil)
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//    } else {
//        [self addAssetsObject:asset];
//        self.sendButton.badgeValue = [NSString stringWithFormat:@"%@",@(self.selectedAssetsArray.count)];
//        return YES;
//    }
    return NO;
}

- (void)deseletedAssets:(DNAsset *)asset {
//    [self removeAssetsObject:asset];
//    self.sendButton.badgeValue = [NSString stringWithFormat:@"%@",@(self.selectedAssetsArray.count)];
//    if (self.selectedAssetsArray.count < 1) {
//        UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
//        firstItem.enabled = NO;
//    }
}

#pragma mark - ui action

- (void)saveAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createBarButtonItemAtPosition:(DNImagePickerNavigationBarPosition)position text:(NSString *)text action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch (position) {
        case DNImagePickerNavigationBarPositionLeft:
            insets = UIEdgeInsetsMake(0, -49 + 26, 0, 19);
            break;
        case DNImagePickerNavigationBarPositionRight:
            insets = UIEdgeInsetsMake(0, 49 - 26, 0, -19);
            break;
        default:
            break;
    }
    
    [button setTitleEdgeInsets:insets];
    [button setFrame:CGRectMake(0, 0, 64, 30)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:Color_FromRGB(0x808080) forState:UIControlStateHighlighted];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    switch (position) {
        case DNImagePickerNavigationBarPositionLeft:
            self.navigationItem.leftBarButtonItem = barButtonItem;
            break;
        case DNImagePickerNavigationBarPositionRight:
            self.navigationItem.rightBarButtonItem = barButtonItem;
            break;
        default:
            break;
    }
}
@end
