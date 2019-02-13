//
//  GKDelegateBaseViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/13.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKDelegateBaseViewController.h"
#import "MeatFactory.h"

#warning 继承协议
@interface GKDelegateBaseViewController () <MeatFactoryDelegate>

@end

@implementation GKDelegateBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Delegate Base";
    
    MeatFactory *factoryView = [[MeatFactory alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [factoryView setBackgroundColor:[UIColor orangeColor]];
    #warning  设置代理
    factoryView.delegate = self;
    
    [self.view addSubview:factoryView];
}

#warning 实现代理方法
-(void)needMeat {
    NSLog(@"肉来了");
}

@end
