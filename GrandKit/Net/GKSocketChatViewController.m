//
//  GKSocketChatViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/21.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKSocketChatViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>



@interface GKSocketChatViewController ()

@property (nonatomic, strong) UITextView *tvMessage;
@property (nonatomic, strong) UIButton *btnSend;
@property (nonatomic, strong) UILabel *lbDialog;

@property (nonatomic, strong) NSMutableArray *mineArray;
@property (nonatomic, strong) NSMutableArray *responseArray;

@property (nonatomic, assign) int socketNumber;

@end

@implementation GKSocketChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Socket Chat";
    
    [self buildUI];
    
    int state = [self startSocket];
    if (state != -1) {
        NSLog(@"connect success!");
        
        [self onReceive];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    @try {
        /* 6.一个请求结束之后(接收到响应之后),需要手动关闭Socket! */
        close(_socketNumber);
        NSLog(@"Socket closed!");
    }
    @catch(NSException *e) {
        NSLog(@"%@", e);
    }
}

- (void)buildUI {
    
    [self.view addSubview:[self getTvMessage]];
    
    [self.view addSubview:[self getBtnSend]];
    [self.btnSend addTarget:self action:@selector(onSend) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:[self getLbDialog]];
}

- (NSMutableArray *)mineArray {
    if (!_mineArray) {
        _mineArray = [[NSMutableArray alloc]init];
    }
    return _mineArray;
}

- (NSMutableArray *)responseArray {
    if (!_responseArray) {
        _responseArray = [[NSMutableArray alloc]init];
    }
    return _responseArray;
}

- (UITextView *)getTvMessage {
    if (!_tvMessage) {
        _tvMessage = [[UITextView alloc]initWithFrame:CGRectMake(PADDING, Size(30), Width - PADDING * 2 - Size(80), Size(40))];
        _tvMessage.font = [UIFont boldSystemFontOfSize:24];
    }
    return _tvMessage;
}

- (UIButton *)getBtnSend {
    if (!_btnSend) {
        _btnSend = [[UIButton alloc]initWithFrame:CGRectMake(Width - PADDING - Size(70), Size(30), Size(70), Size(40))];
        [_btnSend setTitle:@"Send" forState:UIControlStateNormal];
        [_btnSend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnSend.layer setMasksToBounds:YES];
        [_btnSend.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        _btnSend.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [_btnSend.layer setBorderWidth:2.0];
    }
    return _btnSend;
}

- (UILabel *)getLbDialog {
    if (!_lbDialog) {
        _lbDialog = [[UILabel alloc]initWithFrame:CGRectMake(PADDING, Size(90), Width - PADDING * 2, Height - Size(180))];
        _lbDialog.font = [UIFont boldSystemFontOfSize:18];
    }
    return _lbDialog;
}

- (void)refreshDialog {
    
    NSMutableArray *dialogArray = [[NSMutableArray alloc]init];
    [dialogArray addObject:@" > "];
    for (int i = 0; i < 100; i++) {
        if ([_mineArray count] > i) {
            NSString *word = [_mineArray objectAtIndex:i];
            [dialogArray addObject:[NSString stringWithFormat:@"%@\n > ", word]];
        }
        if ([_responseArray count] > i) {
            NSString *echo = [_responseArray objectAtIndex:i];
            [dialogArray addObject:[NSString stringWithFormat:@"%@\n > ", echo]];
        }
    }
    NSString *arrayString = [dialogArray componentsJoinedByString:@""];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.lbDialog.numberOfLines = [dialogArray count];
        self.lbDialog.text = arrayString;
    });
}

- (int)startSocket {
    
    _socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1");
    serverAddress.sin_port = htons(12345);
    
    int state = connect(_socketNumber, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    return state;
}

- (void)sendMessage:(NSString *)messageString {
    
    send(_socketNumber, messageString.UTF8String, strlen(messageString.UTF8String), 0);
    
    [self.mineArray addObject:messageString];
    [self refreshDialog];
}

- (void)onReceive {
    
    dispatch_queue_t queue = dispatch_queue_create("socket.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^ {
        
        while (YES) {
            
            ssize_t buffer[1024];
            ssize_t length = recv(self.socketNumber, buffer, sizeof(buffer), 0);
            NSLog(@"------- received");
            
            // 获得服务器返回的数据(从 buffer 中取出需要的数据)
            
            // 根据二进制数据,拼接字符串
            // Bytes: 网络中传递的数据流(比特流/字节)
            NSString *returnMsg = [[NSString alloc] initWithBytes:buffer length:length encoding:NSUTF8StringEncoding];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.responseArray addObject:returnMsg];
                [self refreshDialog];
            });
            
            continue;
        }
    });
    
}

- (void)onSend {
    
    NSLog(@"------- send");
    
    NSString *messageString = self.tvMessage.text;
    if ([NSString isEmpty:messageString]) {
        return;
    }
    
    self.tvMessage.text = @"";
    
    [self sendMessage:messageString];
}

@end















