//
//  GKURLSessionViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/31.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLSessionViewController.h"
#import "SSZipArchive.h"

@interface GKURLSessionViewController ()

@end

@implementation GKURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // json
//    NSString *urlString = @"http://192.168.0.136:8080/examples/demo.json";
//    NSURL *url = [[NSURL alloc]initWithString:urlString];
//    [self taskWithURL:url];
    
    NSURL *url2 = [[NSURL alloc]initWithString:@"http://192.168.0.136:8080/examples/pdf.zip"];
    [self downloadWithURL:url2];
}

- (void)taskWithURL:(NSURL *)url {
    
    // session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建task
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"result-%@", result);
    }];
    
    // 启动task
    [task resume];
}

- (void)downloadWithURL:(NSURL *)url {
    
    /**
     如果在回调方法中不做任何处理，下载的
     */
    [[[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL *url, NSURLResponse *response, NSError *error){
        NSLog(@"%@", url);
        NSLog(@"%@", error);
        
        // 下载结束，解压缩目标路径
        NSString *targetPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        [SSZipArchive unzipFileAtPath:url.path toDestination:targetPath];
        
    }] resume];
}

@end
