//
//  GKURLSessionDeligateDownloadResumeViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/11.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLSessionDeligateDownloadResumeViewController.h"
#import "RainbowProgress.h"

@interface GKURLSessionDeligateDownloadResumeViewController () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
/* 下载暂停时的续传状态数据 */
@property (nonatomic, strong) NSData *resumeData;
/*
 - 所有任务是被Session发起的，任务一旦发起，Session会对任务进行强引用
 - 任务被取消，session不再进行强引用；在ARC中，如果没有对象对一个对象进行强引用，此对象会被立即释放
 */
//@property (nonatomic, weak) NSData *resumeData;

/** 彩虹进度条 */
@property (nonatomic, strong) RainbowProgress *progress;

@property (nonatomic, strong) UIButton *btnStart;
@property (nonatomic, strong) UIButton *btnStop;
@property (nonatomic, strong) UIButton *btnResume;

@end

@implementation GKURLSessionDeligateDownloadResumeViewController

/**
 使用下载代理时，不能使用全局Session，需要自己创建
 */
- (NSURLSession *)session {
    if (_session == nil) {
        // NSURLSessionConfiguration 提供了一个全局的网络环境配置，包括Cookie，客户端信息，身份验证，缓存，超时时长等
        // 一旦设置可以全局共享，替代NSURLRequest中的配置信息
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        /**
         下载本身是异步的，由NSURLSession统一调度执行
         delegateQueue 代理运行队列——当网络事件需要监听的时候，执行方法所在的队列，不会影响到异步性
         - [NSOperationQueue mainQueue] 代理在主队列中运行
         - nil 和 [[NSOperationQueue alloc]init] 一样。如果只是希望代理异步执行，传入 nil 就可以
         */
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSURLSession Deligate Resume";
    
    [self buildUI];
}

- (void)buildUI {
    
    self.progress = [[RainbowProgress alloc] init];
    [self.progress setFrame:CGRectMake(PADDING, Size(40), Width - PADDING * 2, Size(10))];
    [self.view addSubview:self.progress];
    
    [self.progress startAnimating];
    
    self.btnStart = [UIButton initWithFrame:CGRectMake(PADDING, Size(100), Width - PADDING * 2, COMMON_HEIGHT) title:@"Start"];
    [self.view addSubview:self.btnStart];
    [self.btnStart addTarget:self action:@selector(onStart) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnStop = [UIButton initWithFrame:CGRectMake(PADDING, Size(155), Width - PADDING * 2, COMMON_HEIGHT) title:@"Stop"];
    [self.view addSubview:self.btnStop];
    [self.btnStop addTarget:self action:@selector(onStop) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnResume = [UIButton initWithFrame:CGRectMake(PADDING, Size(210), Width - PADDING * 2, COMMON_HEIGHT) title:@"Resume"];
    [self.view addSubview:self.btnResume];
    [self.btnResume addTarget:self action:@selector(onResume) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    /*
     Session 和 VC 循环引用的问题
     
     
     */
    // 将 session 设为已完成
    // 已完成状态的session，无法再次使用
    [self.session finishTasksAndInvalidate];
    // 清空session
    self.session = nil;
}

- (void)dealloc {
    NSLog(@"ViewController 已释放");
}

- (void)onStart {
    
    NSString *urlString = @"http://192.168.0.136:8080/examples/movie.mkv";
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    self.downloadTask = [self.session downloadTaskWithURL:url];
    // 启动任务
    [self.downloadTask resume];
}

- (void)onStop {
    [self.downloadTask cancelByProducingResumeData:^(NSData * resumeData) {
        NSLog(@"数据长度 %tu", resumeData.length);
        
        // 缓存已下载数据
        self.resumeData = resumeData;
        
        // 将下载任务置空
        self.downloadTask = nil;
    }];
}

- (void)onResume {
    if (self.resumeData == nil) {
        return;
    }
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
    self.resumeData = nil;
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
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        self.progress.progressValue = progress;
    });
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
