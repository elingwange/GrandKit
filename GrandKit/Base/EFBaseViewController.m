//
//  GKBaseViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/19.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "EFBaseViewController.h"

@interface EFBaseViewController ()

@end

@implementation EFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.view.backgroundColor = Color_FromRGB(0xF5F5F5);
}


@end
