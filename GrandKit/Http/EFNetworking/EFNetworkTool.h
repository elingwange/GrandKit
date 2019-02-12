//
//  EFNetworkTool.h
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

@interface EFNetworkTool : NSObject

// 获取单例的方法
+ (instancetype)sharedNetworkTool;

// urlString :post 请求的接口
// 上传给服务器的参数,用字典包装
// paramater : 参数字典
- (void)PostUrlString:(NSString *)urlString
            paramater:(NSDictionary *)paramater
              success:(SuccessBlock)SuccessBlock
                 fail:(FailBlock)failBlock;


// 文件上传的 POST 请求
/**
 *  直接上传文件
 *
 *  @param urlString 上传文件需要的接口
 *  @param filePath  需要上传的文件路径
 *  @param fileKey   服务器接受文件的key值
 *  @param fileName  文件在服务器保存的名称
 *  Block 类型的参数比较特殊: 可以直接执行这个 Block
 *  SuccessBlock:(SuccessBlock(参数类型))Success 形参
 *  FailBlock:(failBlock(参数类型))fail 形参
 */
- (void)PostFileWithUrlString:(NSString *)urlString
                     FilePath:(NSString *)filePath
                      FileKey:(NSString *)fileKey
                     FileName:(NSString *)fileName
                 SuccessBlock:(SuccessBlock)Success
                    FailBlock:(FailBlock)fail;

/**
 *  单文件上传的格式封装(封装的时请求体中的内容)
 *
 *  @param filePath 需要上传的文件路径
 *  @param fileKey  服务器接受文件的key值
 *  @param fileName 文件在服务器上保存的名称(如果传nil ,会使用默认名称)
 *
 *  @return 封装好的请求体内容
 */
- (NSData *)getHttpBodyWithFilePath:(NSString *)filePath
                            FileKey:(NSString *)fileKey
                           FileName:(NSString *)fileName;

/**
 *  根据文件路径获取文件信息
 *
 *  @param filePath 文件路径
 *
 *  @return 文件信息
 */
- (NSURLResponse *)getFileTypeWithFilepath:(NSString *)filePath;


@end

NS_ASSUME_NONNULL_END
