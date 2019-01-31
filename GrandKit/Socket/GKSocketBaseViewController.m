//
//  GKSocketBaseViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/19.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKSocketBaseViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface GKSocketBaseViewController ()

@end

@implementation GKSocketBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Socket Base";
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    /*
     Socket 流程
     1. 创建客户端 Socket
     2. 创建服务端 Socket
     3. 连接两个 Socket
     4. 客户端 Socket 发送信息给服务端
     5. 服务器响应客户端，并回复信息
     6. 客户端接收服务端回复
     7. 关闭 Socket
     */
    
    /* 1. 创建客户端 Socket */
    // 参数1: 协议域: 遵守的IP协议类型! AF_INET:IPv4  AF_INET6:IPv6
    // 参数2: 端口类型: TCP:SOCK_STREAM   UDP:SOCK_DGRAM
    // 参数3: 选择的协议类型! 一般传0 会根据第二个参数自动选择协议类型!
    // 返回值: 如果返回值>0 ,标示 Socket 创建成功!
    
    int socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    
    NSLog(@"SocketNumber: %d", socketNumber);
    
    
    /* 2. 创建服务器端 Socket */
    
    struct sockaddr_in serverAddress;
    
    // 主机 /端口
    // 设置 服务器Socket 遵循的 IP 协议类型为 IPv4
    serverAddress.sin_family = AF_INET;
    
    // 服务器 Socket 的 IP 地址
    serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    // 设置服务器Socket 的端口号; 目前端口号设置的是 12345
    // 端口号的最大值 65535;  09~1024 是系统默认占用的端口号!不要设置!
    // 如果需要手动设置端口号: 一般设置 1024 ~ 65535 之间的值!
    serverAddress.sin_port = htons(12345);
    
    
    /* 3. 连接两个 Socket */
    // 参数1: 客户端的 Socket
    // 参数2: 服务器端 Socket/结构体 (const struct sockaddr *)&serverAddress 强制类型转换
    // 参数3: 第二个参数的长度! sizeof(serverAddress) 计算长度! 计算的是内存地址的长度!
    // 返回值: 如果返回值为0 代表连接成功!
    // 返回值 != 0 ,代表连接失败!
    // 如果想要连接成功,必须实时监测服务器端的端口!
    // 监测服务器端口: nc -lk 12345
    int state = connect(socketNumber, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    
    NSLog(@"state: %d", state);
    
    
    /* 4. 发送信息给服务器 */
    // 参数1: 客户端 Socket
    // 参数2: void * 传递给服务器的数据!  msg.UTF8String 就是直接将 OC 数据转换成 C 语言的数据类型!
    // 参数3: size_t 锁传递给服务器数据的长度!
    // 参数4: 传0 等待服务器响应数据!
    
    NSString *msg = @"hello socket\r\n";
    
    send(socketNumber, msg.UTF8String, strlen(msg.UTF8String), 0);
    
    
    /* 5. 接受服务器返回的数据! */
    // 参数1:客户端 Socket :服务器确定返回给哪一个客户端数据.
    // 参数2:void * :接收服务器返回数据的地址(区域)
    // 参数3:size_t :接受地址的长度
    // 参数4:传0 等待服务器返回数据!
    // 返回值: 就是服务器返回的数据长度!
    
    ssize_t buffer[1024];
    
    ssize_t length = recv(socketNumber, buffer, sizeof(buffer), 0);
    
    // 获得服务器返回的数据(从 buffer 中取出需要的数据)
    
    // 根据二进制数据,拼接字符串
    // Bytes: 网络中传递的数据流(比特流/字节)
    NSString *returnMsg = [[NSString alloc] initWithBytes:buffer length:length encoding:NSUTF8StringEncoding];
    
    NSLog(@"returnMsg: %@", returnMsg);
    
    /* 6.一个请求结束之后(接收到响应之后),需要手动关闭Socket! */
    close(socketNumber);
    
}

@end





















