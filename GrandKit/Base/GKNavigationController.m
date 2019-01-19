//
//  GKNavigationViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/19.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKNavigationController.h"

@interface GKNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation GKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航背景
    [self.navigationBar setBackgroundImage:[UIImage createImageWithColor:Color_FromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    //导航字体颜色
    self.navigationBar.barTintColor = Color_FromRGB(0x263638);
    self.navigationBar.tintColor = Color_FromRGB(0x263638);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: Color_FromRGB(0x263638), NSFontAttributeName : [UIFont semiboldFont:20]};
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_arrow_back"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.interactivePopGestureRecognizer.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"ic_arrow_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goBackPage)];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)goBackPage{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self popViewControllerAnimated:YES];
    });
}

@end
