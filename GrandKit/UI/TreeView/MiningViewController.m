//
//  MiningViewController.m
//  GrandKit
//
//  Created by Evan on 2019/9/4.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "MiningViewController.h"
#import "LeafView.h"
#import "TreeView.h"

@interface MiningViewController()

@end


@implementation MiningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mining/TreeView";
    
    UIImageView *ivBg = [[UIImageView alloc]initWithFrame:self.view.frame];
    ivBg.image = [UIImage imageNamed:@"bg_tree"];
    [self.view addSubview:ivBg];
    
    TreeView *tree = [TreeView new];
//    tree.backgroundColor = [UIColor redColor];
    tree.frame = CGRectMake(0, 0, self.view.frame.size.width - 10, self.view.frame.size.height);
    [self.view addSubview:tree];
}

@end
