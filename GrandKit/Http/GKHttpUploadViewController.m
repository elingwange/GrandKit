//
//  GKURLPostEncapsulateViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKHttpUploadViewController.h"
#import "EFNetworkTool.h"

@interface GKHttpUploadViewController ()

@end

@implementation GKHttpUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Http Upload";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    // 单文件上传
    [self upload];
    
    // 多文件和文本上传
//    [self multiFileUpload];
}

- (void)upload {
    
    EFNetworkTool *tool = [EFNetworkTool sharedNetworkTool];
    
    [tool PostFileWithUrlString:@"http://localhost/upload/upload.php" FilePath:@"/Users/apple/Desktop/vedios.json" FileKey:@"userfile" FileName:nil SuccessBlock:^(NSData *data, NSURLResponse *response) {
        //
        NSLog(@"请求成功");
        
    } FailBlock:^(NSError *error) {
        //
        NSLog(@"网络链接错误");
    }];
}

- (void)multiFileUpload {
    
    // 上传参数(文件参数 + 普通文本参数)
    
    NSString *file1 = @"/Users/apple/Desktop/3741537_011015631000_2.jpg";
    NSString *name1 = @"风景这边独美";
    
    NSString *file2 = @"/Users/apple/Desktop/bba1cd11728b47101344d55bc3cec3fdfc032339.jpg";
    NSString *name2 = @"萌萌哒";
    
    NSDictionary *fileDict = @{name1:file1,name2:file2};
    
    NSString *key1 = @"username";
    NSString *msg1 = @"zhangsan";
    
    NSString *key2 = @"password";
    NSString *msg2 = @"12345678i9o0-098765";
    
    NSDictionary *paramater = @{key1:msg1,key2:msg2};
    
    
    [[EFNetworkTool sharedNetworkTool] PostFileAndMsgWithUrlString:@"http://localhost/upload/upload-m.php" FileDict:fileDict fileKey:@"userfile[]" paramater:paramater success:^(id responseObject, NSURLResponse *response) {
        // responseObject 解析完毕之后的数据: OC 数据
        
        NSLog(@"请求成功: responseObject %@",responseObject);
        
        
    } fail:^(NSError *error) {
        //
        
        NSLog(@"网络错误!");
    }];
}


@end
