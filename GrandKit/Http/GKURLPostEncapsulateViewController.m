//
//  GKURLPostEncapsulateViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLPostEncapsulateViewController.h"
#import "GKNetworkTool.h"

@interface GKURLPostEncapsulateViewController ()

@end

@implementation GKURLPostEncapsulateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Http Post Block";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 登陆请求 //POST
    
    // 1.实例化网络工具类单例
    GKNetworkTool *tool = [GKNetworkTool sharedNetworkTool];
    
    // 2. 发送网络请求
    [tool PostUrlString:@"http://localhost/login/login.php" paramater:@{@"username":@"zhangsan",@"password":@"zhang"} completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}

@end
