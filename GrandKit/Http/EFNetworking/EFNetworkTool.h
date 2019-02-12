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
typedef void(^SuccessJson)(id responseObject, NSURLResponse *response);

@interface EFNetworkTool : NSObject

// 获取单例的方法
+ (instancetype)sharedNetworkTool;


/**
 *  直接封装(多文件+文本信息)上传
 *
 *  @param urlString  接口
 *  @param fileDict   文件字典
 *  @param fileKey    服务器接受文件的key值
 *  @param paramaters 普通文本信息字典
 *  @param success    成功之后的回调
 *  @param fail       失败之后的回调
 *
 *  本方法默认处理服务器返回的JSON数据(自动解析JSON数据)
 */
- (void)PostFileAndMsgWithUrlString:(NSString *)urlString
                           FileDict:(NSDictionary *)fileDict
                            fileKey:(NSString *)fileKey
                          paramater:(NSDictionary *)paramaters
                            success:(SuccessJson)success
                               fail:(FailBlock)fail;

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
 *  多文件上传+普通文本信息 格式封装
 *
 *  @param fileDict   文件字典: key(文件在服务器保存的名称)=value(文件路径)
 *  @param fileKey    服务器接受文件信息的key值
 *  @param paramaters 普通参数字典: key(服务器接受普通文本信息的key)=value(对应的文本信息)
 *
 *  @return 封装好的二进制数据(请求体)
 */
- (NSData *)getHttpBodyWithFileDict:(NSDictionary *)fileDict
                            fileKey:(NSString *)fileKey
                          paramater:(NSDictionary *)paramaters;

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
