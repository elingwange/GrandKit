//
//  GKNetworkTool.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKNetworkTool.h"

@implementation GKNetworkTool : NSObject

// 对外提供的 POST 请求,应该给外界一个 Block 让外界自己选择 成功或者失败之后的操作!
- (void)PostUrlString:(NSString *)urlString
            paramater:(NSDictionary *)paramater
    completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    // 1.创建请求 (POST请求)
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法:
    request.HTTPMethod = @"POST";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    // 将字典中的参数取出来!拼接成字符串! 参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // nameKey: 服务器接收参数的 key 值.
        // nameValue : 上传给服务器的参数内容.
        NSString *nameKey = key;
        NSString *nameValue = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&", nameKey, nameValue]];
        
    }];
    
    // 处理字符串,去掉最后一个字符!
    
    NSLog(@"strM:%@", strM);
    
    
    // 设置请求体:
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发送请求
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 执行完成之后的回调(模仿系统)
        completionHandler(data, response, error);
        
    }] resume];
}

// 获得单例对象(一次性代码)
// 只有通过这个方法获得的才是单例对象!
// 不要把所有的后门都给堵死,让别人自己选择实例化对象的方法!
+ (instancetype)sharedNetworkTool {
    
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

@end
