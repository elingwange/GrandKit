//
//  GKAFNUploadViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKAFNUploadViewController.h"
#import "AFNetworking.h"
#import "EFNetworkTool.h"

@implementation GKAFNUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Upload AFN";
    
    
    // 使用 AFN ,导入 AFNetworking.h
    
    // AFHTTPRequestOperationManager 开发中最常见的! 负责发送网络请求. 内部是对 NSUrlConnection 的封装!
    
    // AFHTTPSessionManager Xcode7 之后使用最多的类! 内部封装的时 NSUrlSession.
    // AFHTTPSessionManager 中发送网络请求的方法名称和AFHTTPRequestOperationManager是一模一样的!
    
    // AFNetworkReachabilityManager: 监测网络状态(实时监测应用当前的网络情况 3G/4G WIFI m没有网络 未知的网络状态)
    
    // AFSecurityPolicy : 安全策略: 用来做安全 HTTPS : 安全需要服务器支持!
    
    // AFURLRequestSerialization :序列化工具:只能使用他的子类!
    // AFN 默认情况下,会解析 JSON 数据!
    // 如果服务器传回来的不是 JSON 数据,如要手动执行解析器类型!
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 上传文件的文件路径
    NSString *filePath = @"/Users/apple/Desktop/bba1cd11728b47101344d55bc3cec3fdfc032339.jpg";
    
    // 实例化自己写的网络工具类! 目的:获得文件类型!
    EFNetworkTool *tool = [EFNetworkTool sharedNetworkTool];
    
    NSURLResponse *response = [tool getFileTypeWithFilepath:filePath];
    
    NSString *type = response.MIMEType;
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    
    // 使用 AFN 实现文件上传!  AFN 只支持单文件上传! ASI 支持多文件上传!
    
    // 1.实例化网络工具管理类!
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.选择请求方法,发送请求! 上传: POST
    
    // 参数1:urlString : 网络接口
    // 参数2:parameters :需要上传的普通文本参数! 在开发中,一般都是传递字典!
    // 参数3:^(id<AFMultipartFormData> formData):封装上传的请求参数! formData:通过设置这个值,来设置请求体中的内容(格式化之后的上传数据)
    // 参数4:success :成功之后的回调
    // 参数5:failure :失败时候的回调
    
    [manager POST:@"http://localhost/upload/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // FileData:需要上传的文件的二进制数据!
        // name:服务器接受文件参数的 key 值!
        // fileName:文件在服务器上保存的名称!
        // mimeType:上传文件的文件类型!
        [formData appendPartWithFileData:data name:@"userfile" fileName:@"美女" mimeType:type];
        
        /*
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", filePath]];

        // FileData:需要上传的文件的二进制数据!
        // name:服务器接受文件参数的 key 值!
        // fileName:文件在服务器上保存的名称!
        // mimeType:上传文件的文件类型!
        [formData appendPartWithFileURL:url name:@"userfile" fileName:@"meinv" mimeType:type error:NULL];
         */
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 返回的是 OC 数据!
        NSLog(@"网络请求成功: responseObject:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        NSLog(@"网络请求失败");
    }];
}

@end
