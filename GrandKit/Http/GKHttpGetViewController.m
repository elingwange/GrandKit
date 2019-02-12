//
//  GKURLGetViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKHttpGetViewController.h"

@interface GKHttpGetViewController ()

@end

@implementation GKHttpGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Http Get";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 1. 带参数的网络请求!
    
    // 如果需要上传参数给服务器!
    
    // 1.参数格式: key=value (key:服务器接受参数的key值,在实际开发中,后端人员/接口文档中会告诉你. value:就是需要告诉服务器的具体参数内容)
    // 2.一般情况下,服务器需要我们提供多个参数! 参数和参数之间以 & 分隔 username=zhangsan&password=zhang
    
    // 1.第一种告诉服务器参数的方法: 将参数拼接在 url 中! 注意:在 ? 后面拼接参数! 一个 url 中, ? 后面的内容都是参数!
    
    // GET :http请求方法,从服务器获取数据! 如果使用 get 请求发送参数给服务器,需要将参数拼接在 url 中!
    // 缺点: 所有的参数都暴露在 url 中. 信息会让别人看的一清二楚! 信息不安全!
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/login/login.php?username=zhangsan&password=zhang"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 处理服务器返回的数据!
        
        NSLog(@"data:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        
    }] resume];
    
}

@end
