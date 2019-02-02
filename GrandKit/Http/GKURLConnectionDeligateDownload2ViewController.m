//
//  GKURLSessionViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/24.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLConnectionDeligateDownload2ViewController.h"

@interface GKURLConnectionDeligateDownload2ViewController () <NSURLConnectionDataDelegate>

/** 文件的总字节长度  */
@property (nonatomic, assign) long long expectedContentLength;
/** 当前已传输的字节长度  */
@property (nonatomic, assign) long long currentLength;

/** 保存的目标路径  */
@property (nonatomic, strong) NSString *targetFileName;

@property (nonatomic, strong) NSOutputStream *os;

@end

@implementation GKURLConnectionDeligateDownload2ViewController

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
 
 2-下载一个写一个
 NSFileHandle 彻底解决内存峰值的问题
 
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 1-url
    NSString *urlString = @"http://192.168.0.136:8080/examples/movie.mkv";
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
    // 如果文件已存在则删除
    [[NSFileManager defaultManager]removeItemAtPath:self.targetFileName error:nil];
}

// 2-接收到服务器的数据 - 此代理方法可能回调多次，因为会收到多个NSData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //    NSLog(@"接收到的数据长度-%tu", data.length);
    
    self.currentLength += data.length;
    float pregress = (float) self.currentLength / self.expectedContentLength;
    NSLog(@"pregress-%lf", pregress);
    
    // 拼接数据
    [self writeToFileWithData:data];
}

- (void)writeToFileWithData:(NSData *)data {
    /**
     文件操作：
     NSFileManager: 主要功能，创建目录，检查目录是否存在，遍历目录，删除文件... 针对文件级的操作，类似于Finder
     NSFileHandle：文件指针，对文件进行二进制的读写操作
     */
    
    // 文件不存在，则 handle 为空
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.targetFileName];
    // 判断文件是否存在
    // 文件不存在，直接将数据写入磁盘
    if (handle == nil) {
        [data writeToFile:self.targetFileName atomically:YES];
    }
    // 文件存在，直接将数据追加到文件中
    else {
        // 将指针移动到文件末尾
        [handle seekToEndOfFile];
        // 写入数据
        [handle writeData:data];
        // 关闭文件。在C语言中，文件的打开和关闭是成对出现的
        [handle closeFile];
    }
}

// 3-所有数据加载完成 - 所有数据传输完成后回调一次
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"trans finish!");
    
}

// 4-下载失败或者错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}




@end
