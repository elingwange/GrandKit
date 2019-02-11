//
//  GKURLSessionDeligateDownloadViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/2.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLSessionDeligateDownloadViewController.h"
#import "RainbowProgress.h"

@interface GKURLSessionDeligateDownloadViewController () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
/** 彩虹进度条 */
@property (nonatomic, strong) RainbowProgress *progress;

@end

@implementation GKURLSessionDeligateDownloadViewController

/**
 使用下载代理时，不能使用全局Session，需要自己创建
 */
- (NSURLSession *)session {
    if (_session == nil) {
        // NSURLSessionConfiguration 提供了一个全局的网络环境配置，包括Cookie，客户端信息，身份验证，缓存，超时时长等
        // 一旦设置可以全局共享，替代NSURLRequest中的配置信息
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSURLSession Deligate";
    
    self.progress = [[RainbowProgress alloc] init];
    [self.view addSubview:self.progress];
    
    [self.progress startAnimating];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    /**
     如果要跟进下载进度，不能使用任务回调的方式
     */
    
    NSString *urlString = @"http://192.168.0.136:8080/examples/movie.mkv";
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url];
    // 启动任务
    [downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate 代理方法

/**
 下载完成时调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSLog(@"完成 %@", location);
    
    [self.progress stopAnimating];
}

/**
 下载过程中调用，用于跟踪下载进度
 
 session:
 downloadTask                   调用代理方法的下载任务
 bytesWritten                   本次下载的字节数
 totalBytesWritten              已经下载的字节数
 totalBytesExpectedToWrite      期望下载的字节数->文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    float progress = (float) totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f", progress);
    
    self.progress.progressValue = progress;
}

/*
 下载恢复时调用
 * 在使用downloadTaskWithResumeData:方法获取到对应NSURLSessionDownloadTask，
 * 并该task调用resume的时候调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    // 什么都不用写
}

@end
