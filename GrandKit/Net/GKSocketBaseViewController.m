//
//  GKSocketBaseViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/19.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKSocketBaseViewController.h"
#import "UIImage+Com.h"

@interface GKSocketBaseViewController ()

@end

@implementation GKSocketBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:Color_FromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];


    //导航字体颜色
//    self.navigationBar.barTintColor = k263238;
//    self.navigationBar.tintColor = k263238;
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: k263238, NSFontAttributeName : [UIFont semiboldFont:20]};

    
    
    
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"ic_arrow_return"];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"ic_arrow_return"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_arrow_return"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationItem.backBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

@end
