//
//  GKURLPostEncapsulateViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKURLPostUploadViewController.h"
#import "EFNetworkTool.h"

@interface GKURLPostUploadViewController ()

@end

@implementation GKURLPostUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Http Post Block";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    
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


@end
