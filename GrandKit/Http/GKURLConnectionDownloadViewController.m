//
//  GKURLConnectionDownloadViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/24.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLConnectionDownloadViewController.h"

@interface GKURLConnectionDownloadViewController ()

@end

@implementation GKURLConnectionDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSURLConnection Download";
}

/**
 NSURLConnection
 
 - 开发简单的网络请求较简单，可使用异步方法
 - 开发复杂的网络请求，如大文件下载，需使用代理开发，比较繁琐
 
 问题：
    1-没有下载进度，影响用户体验
    2-有内存峰值！下载的文件有多大，NSData就会占用多大的内存
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
    NSLog(@"--- start!");
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
                               
           NSString *documentsPath =[self getDocumentsPath];
           NSString *filePath = [documentsPath stringByAppendingPathComponent:@"demo.avi"];
           BOOL state = [data writeToFile:filePath atomically:YES];
           if (state) {
               NSLog(@"--- saving is completed!");
           }
    }];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:url
//            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//                BOOL state = [data writeToFile:@"/Users/evan/Desktop" atomically:YES];
//                if (state) {
//                    NSLog(@"--- saving is completed!");
//                }
//            }] resume];
}

// 获取Documents路径
- (NSString *)getDocumentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end


















