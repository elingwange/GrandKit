//
//  GKNetworkTool.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义两个 Block : 1. 成功Block回调 2.失败的 Block 回调!
// 定义 Block 的方式:
typedef void(^SuccessBlock)(NSData *data, NSURLResponse *response);
typedef void(^FailBlock)(NSError *error);

@interface GKNetworkTool : NSObject

// urlString :post 请求的接口
// 上传给服务器的参数,用字典包装
// paramater : 参数字典
- (void)PostUrlString:(NSString *)urlString
            paramater:(NSDictionary *)paramater
              success:(SuccessBlock)SuccessBlock
                 fail:(FailBlock)failBlock;

// 获取单例的方法
+ (instancetype)sharedNetworkTool;

@end

NS_ASSUME_NONNULL_END
