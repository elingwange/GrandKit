//
//  GKURLSessionViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/24.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLConnectionDeligateDownload3ViewController.h"

@interface GKURLConnectionDeligateDownload3ViewController () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) UILabel *lbDesc;
@property (nonatomic, strong) UIProgressView *pvDownload;


/** 文件的总字节长度  */
@property (nonatomic, assign) long long expectedContentLength;
/** 当前已传输的字节长度  */
@property (nonatomic, assign) long long currentLength;

/** 保存的目标路径  */
@property (nonatomic, strong) NSString *targetFileName;

/**
 - (void)open;
 - (void)close;
 */
@property (nonatomic, strong) NSOutputStream *os;

//@property (nonatomic, assign, getter=isFinished) BOOL finished;
/** 下载线程的运行循环 */
@property (nonatomic, assign) CFRunLoopRef downloadRunloop;

@end

@implementation GKURLConnectionDeligateDownload3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSURLConnection Deligate";
    
    self.lbDesc = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, Size(30), Width - PADDING * 2, 0)];
    self.lbDesc.text = @"异步执行下载操作，使用运行循环监听网络事件";
    self.lbDesc.numberOfLines = 0;
    [self.lbDesc sizeToFit];
    [self.view addSubview:self.lbDesc];
    
    self.pvDownload = [[UIProgressView alloc]initWithFrame:CGRectMake(PADDING, Size(300), Width - PADDING * 2, Size(50))];
    [self.view addSubview:self.pvDownload];
    
}

/**
 
 问题：
 启动子线程执行下载，
 
 RunLoop 运行循环
 1-负责触摸、输入、时钟和网络
 2-主线程的运行循环会自动启动，而子线程的运行循环默认不启动
 
 启动方式一
    [[NSRunLoop currentRunLoop]run];
 
    问题：需要设定退出条件，否则会一直运行
 
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 将网络操作放在异步线程中执行，而子线程中的运行循环是默认不启动的，没有办法监听到网络事件
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1-url
        NSString *urlString = @"http://192.168.0.136:8080/examples/movie.mkv";
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        // 2-request
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        NSLog(@"--- start, %@", [NSThread currentThread]);
        
        // 3-connection
        // 为了保证连接的工作正常，需要运行在默认的运行循环下
        NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
        
        // 设置网络操作所在的操作队列
        [conn setDelegateQueue:[[NSOperationQueue alloc]init]];
        
        // 4-start
        [conn start];
        
        /*
        // 启动运行循环的方式一
        self.finished = NO;
        if (!self.isFinished) {
            
            [[NSRunLoop currentRunLoop]run];
            
            // 启动一个死循环，间隔0.1秒循环监听——对系统消耗很大
//            [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        }
         */
        
        /**
         CoreFoundation框架（纯C语言实现，Foundation框架的基础）中，提供了对运行循环更底层的操作
            CFRunLoopGetCurrent     获取当前线程的RunLoop
            CFRunLoopStart          启动运行循环
            CFRunLoopStop(rl)       停止制定线程的RunLoop
         */
        self.downloadRunloop = CFRunLoopGetCurrent();
        CFRunLoopRun();
        
        NSLog(@"--- end");
    });
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
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pvDownload.progress = 0;
    });
    
    self.targetFileName = [@"/Users/evan/Desktop" stringByAppendingPathComponent:response.suggestedFilename];
    // 如果文件已存在则删除
    [[NSFileManager defaultManager]removeItemAtPath:self.targetFileName error:nil];
    
    // 创建流实例并开启
    self.os = [[NSOutputStream alloc]initToFileAtPath:self.targetFileName append:YES];
    [self.os open];
}

// 2-接收到服务器的数据 - 此代理方法可能回调多次，因为会收到多个NSData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //    NSLog(@"接收到的数据长度-%tu", data.length);
    
    self.currentLength += data.length;
    float pregress = (float) self.currentLength / self.expectedContentLength;
    NSLog(@"pregress-%lf", pregress);
    
    // 更新进度条进度
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.pvDownload.progress = pregress;
    });
    
    [self.os write:data.bytes maxLength:data.length];
}


// 3-所有数据加载完成 - 所有数据传输完成后回调一次
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    /** 代理工作结束时所在的线程，是指定的 NSOperationQueue 调度的 */
    NSLog(@"--- done! %@", [NSThread currentThread]);
    
    // 关闭流
    [self.os close];
    
//    self.finished = YES;
    
    // 停止运行循环
    CFRunLoopStop(self.downloadRunloop);
}

// 4-下载失败或者错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}




@end
