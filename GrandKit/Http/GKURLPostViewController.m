//
//  GKURLPostViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLPostViewController.h"

@interface GKURLPostViewController ()

@end

@implementation GKURLPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Http Post";
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    
    // 1. 创建请求:由于 POST 请求需要手动指定 http 的请求方法为 POST ,所以只能用 可变请求!
    
    // 接口
    NSURL *url = [NSURL URLWithString:@"http://localhost/login/login.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法为 POST ; 默认情况下,所有的请求都是 GET 请求.
    request.HTTPMethod = @"POST";
    
    // POST 请求的参数,都是放在请求体中的! 注意:请求体是二进制数据!
    
    // 设置请求体内容:
    NSString *str = [NSString stringWithFormat:@"username=zhangsan&password=zhang"];
    
    // 将请求体字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = data;
    
    
    // 2. 发送请求 // POST 请求只能使用下面这个方法!
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        NSLog(@"data:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
    }] resume];
    
}

@end
