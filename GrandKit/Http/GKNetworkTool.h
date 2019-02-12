//
//  GKNetworkTool.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKNetworkTool : NSObject

// urlString :post 请求的接口
// 上传给服务器的参数,用字典包装
// paramater : 参数字典
- (void)PostUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

// 获取单例的方法
+ (instancetype)sharedNetworkTool;

@end

NS_ASSUME_NONNULL_END
