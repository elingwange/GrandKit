//
//  GKURLSessionViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/24.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLConnectionDeligateDownloadViewController.h"

@interface GKURLConnectionDeligateDownloadViewController () <NSURLConnectionDataDelegate>

/** 文件的总字节长度  */
@property (nonatomic, assign) long long expectedContentLength;
/** 当前已传输的字节长度  */
@property (nonatomic, assign) long long currentLength;

/** 保存的目标路径  */
@property (nonatomic, strong) NSString *targetFileName;
/** 增量保存数据  */
@property (nonatomic, strong) NSMutableData *fileData;

@end

@implementation GKURLConnectionDeligateDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSURLConnection Deligate";
}

/**
 
 问题：
 1-没有下载进度，影响用户体验
 2-有内存峰值！下载的文件有多大，NSData就会占用多大的内存
 
 解决方法：
 - 通过代理的方式
 
 1.下载进度
    1-在代理方法中获取文件的总大小
    2-每次接收数据，计算已接收数据大小和总大小的比值，即下载进度

 2.保存文件
 
    1-保存完成写入磁盘，释放内存
    问题：仍存在内存峰值
    推测：iOS5推出的异步方法，就是一样的实现
 
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 1-url
    NSString *urlString = @"http://192.168.0.136:8080/examples/demo.avi";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2-request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3-connection
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // 4-start
    [conn start];
}

#pragma mark - NSURLConnectionDataDelegate

// 1-接收到服务器的响应 状态行&消息头
/**
 expectedContentLength 要下载文件的总大小
 suggestedFilename 服务器建议使用的文件名
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", response);
    
    self.expectedContentLength = response.expectedContentLength;
    self.currentLength = 0;
    
    self.targetFileName = [@"/Users/evan/Desktop" stringByAppendingPathComponent:response.suggestedFilename];
    self.fileData = [[NSMutableData alloc]init];
}

// 2-接收到服务器的数据 - 此代理方法可能回调多次，因为会收到多个NSData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"接收到的数据长度-%tu", data.length);
    
    self.currentLength += data.length;
    float pregress = (float) self.currentLength / self.expectedContentLength;
    NSLog(@"pregress-%lf", pregress);
    
    // 拼接数据
    [self.fileData appendData:data];
}


// 3-所有数据加载完成 - 所有数据传输完成后回调一次
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"trans finish!");
    
    [self.fileData writeToFile:self.targetFileName atomically:YES];
    // 释放内存
    self.fileData = nil;
}

// 4-下载失败或者错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
