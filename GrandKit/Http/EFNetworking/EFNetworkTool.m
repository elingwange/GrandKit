//
//  EFNetworkTool.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/12.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "EFNetworkTool.h"

#define kBounary @"bounary"


@implementation EFNetworkTool : NSObject

// 获得单例对象(一次性代码)
// 只有通过这个方法获得的才是单例对象!
// 不要把所有的后门都给堵死,让别人自己选择实例化对象的方法!
+ (instancetype)sharedNetworkTool {
    
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

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
                               fail:(FailBlock)fail {
    
    // 1. 创建请求
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法
    request.HTTPMethod = @"POST";
    
    // 设置请求头,告诉服务器本次长传的时文件信息
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBounary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPBody = [self getHttpBodyWithFileDict:fileDict fileKey:fileKey paramater:paramaters];
    
    // 2. 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // 如果请求成功,调用成功的回调!
        if (data && !connectionError) {
            
            if (success) {
                
                // JSON --> OC  解析JSON 数据
                id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                // 成功回调
                success(obj,response);
            }else
            {
                if (fail) {
                    // 失败回调
                    fail(connectionError);
                }
            }
        }
    }];
}

// 对外提供的 POST 请求,应该给外界一个 Block 让外界自己选择 成功或者失败之后的操作!
- (void)PostUrlString:(NSString *)urlString
            paramater:(NSDictionary *)paramater
              success:(SuccessBlock)SuccessBlock
                 fail:(FailBlock)failBlock {
    
    // 1.创建请求 (POST请求)
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法:
    request.HTTPMethod = @"POST";
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@""];
    
    // 将字典中的参数取出来!拼接成字符串! 参数和参数之间以 & 间隔
    [paramater enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // nameKey: 服务器接收参数的 key 值.
        // nameValue : 上传给服务器的参数内容.
        NSString *nameKey = key;
        NSString *nameValue = obj;
        
        [strM appendString:[NSString stringWithFormat:@"%@=%@&",nameKey,nameValue]];
        
    }];
    
    // 处理字符串,去掉最后一个字符!
    strM = [strM substringToIndex:(strM.length - 1)];
    
    NSLog(@"strM:%@",strM);
    
    // 设置请求体:
    request.HTTPBody = [strM dataUsingEncoding:NSUTF8StringEncoding];
    
    // 发送请求
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 成功:
        if (data && !error) { //没有错误,并且有数据返回!
            
            // 成功执行,执行成功的Block 回调!
            if (SuccessBlock) {
                // 执行 Block
                SuccessBlock(data,response);
            }
            
        } else { // 网路请求失败
        
            if (failBlock) {
                // 失败之后的回调!
                failBlock(error);
            }
        }
        
    }] resume];
}

- (void)PostFileWithUrlString:(NSString *)urlString
                     FilePath:(NSString *)filePath
                      FileKey:(NSString *)fileKey
                     FileName:(NSString *)fileName
                 SuccessBlock:(SuccessBlock)Success
                    FailBlock:(FailBlock)fail {
    
    // 文件上传  POST请求
    
    // 1. 创建请求
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法
    request.HTTPMethod = @"POST";
    
    // 设置请求头,告诉服务器本次长传的文件信息
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBounary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    // 设置请求体
    request.HTTPBody = [self getHttpBodyWithFilePath:filePath FileKey:fileKey FileName:fileName];
    
    
    // 2. 发送请求
    // [NSOperationQueue mainQueue] :一定要注意线程!(Block 回调的线程!)
    // 这里面的 Block 是系统的 Block : 是网络请求完成之后的 Block 回调(系统自动调用)
    // 在系统内的Block 中调用自己的 成功或者失败回调!
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //
        //        NSLog(@"response:%@",response);
        //        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        // 成功或者失败:根据公司服务器返回的参数自己判定!
        
        if (data && !connectionError) {  // 成功
            
            // 调用 成功的回调
            if (Success) {
                // 调用 Block // 执行 Block.
                Success(data,response);
            }
        } else {
            if (fail) {
                // 失败之后的回调!
                fail(connectionError);
            }
        }
    }];
}


// 如果:上传一张图片!
// filePath: 需要上传的文件路径! (手机访问相册!选择一张图片.是拿到图片的二进制数据?还是拿到图片的路径? -- 路径!)
// fileKey : 服务器接受文件的 key 值
// fileName: 文件上传到服务器之后保存的名称
// 上传文件的文件类型!(根据文件路径,自动获得文件类型!)

// 设置请求体内容
- (NSData *)getHttpBodyWithFilePath:(NSString *)filePath
                            FileKey:(NSString *)fileKey
                           FileName:(NSString *)fileName {
    
    // 根据文件路径,发送同步请求,获得文件信息!
    NSURLResponse *response = [self getFileTypeWithFilepath:filePath];
    
    // 将需要上传的文件格式都转换成二进制数据,然后传给请求体!
    NSMutableData *data = [NSMutableData data];
    
    // 1. 上传文件的上边界  \r\n :保证一定会换行,所有的服务器都认识! \n就是换行
    NSMutableString *headerStrM = [NSMutableString stringWithFormat:@"--%@\r\n",kBounary];
    
    // 如果用户没有传在服务器中保存的文件名称,默认用建议的文件名!
    if (!fileName) {
        fileName = response.suggestedFilename;
    }
    
    NSString *contentType = response.MIMEType;
    
    // 参数: userfile: 服务器接受文件参数的 key 值! 肯定是服务器人员告诉我们!
    // filename :文件上传到服务器之后保存的名称!可以自己指定!
    [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n", fileKey, fileName];
    // Content-Type:所上传文件的文件类型! application/octet-stream:数据流格式!如果不知道文件类型,可以直接用这个数据流的格式写!
    // 注意: 这一行后面是两个换行!
    [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n", contentType];
    
    // 将上边界字符串方法请求体
    [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // 2 .上传的文件内容
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    [data appendData:fileData];
    
    // 3. 上传文件的下边界
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--", kBounary];
    
    [data appendData:[footerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    return data;
}
                  
                  
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
                            paramater:(NSDictionary *)paramaters {

    NSMutableData *data = [NSMutableData data];
    
    // 遍历文件参数字典,设置文件的格式(会将所上传的文件数据格式封装起来)
    [fileDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 取出每一条字典数据: fileName : 服务器保存的名称 , filePath: 文件路径
        NSString *fileName = key;
        NSString *filePath = obj;
        
        // 1.第一个文件的上边界
        NSMutableString *headerStrM = [NSMutableString stringWithFormat:@"\r\n--%@\r\n",kBounary];
        
        // "userfile[]" 服务器接受文件的 key 值
        // "ARRAYJSON"  服务器保存的文件名
        [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",fileKey,fileName];
        
        NSURLResponse *response = [self getFileTypeWithFilepath:filePath];
        
        // 文件类型
        [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n",response.MIMEType];
        
        // 将文件的上边界添加到请求体中!
        [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 将文件内容添加到请求体中
        [data appendData:[NSData dataWithContentsOfFile:filePath]];
        
    }];
    
    // 遍历普通参数字典
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // msgKey :服务器接受参数的key值 msgValue:上传的文本参数
        NSString *msgKey = key;
        NSString *msgValue = obj;
        
        // 普通文本信息上边界
        NSMutableString *headerStrM = [NSMutableString stringWithFormat:@"\r\n--%@\r\n",kBounary];
        // "username": 服务器接受普通文本参数的key值.后端人员告诉我们的!
        [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n",msgKey];
        
        [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 普通文本信息;
        [data appendData:[msgValue dataUsingEncoding:NSUTF8StringEncoding]];
        
    }];
    
    // 3. 下边界 (只添加一次)
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",kBounary];
    [data appendData:[footerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    return data;
}
                  

// 动态获取文件类型!
- (NSURLResponse *)getFileTypeWithFilepath:(NSString *)filePath {
    // 通过发送一个同步请求,来获得文件类型!
    
    // 根据本地文件路径,设置一个本地的 url
    NSString *urlString = [NSString stringWithFormat:@"file://%@",filePath];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 1. 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送一个同步请求,来获得文件类型
    // 同步方法:
    // 参数1: 请求,和之前的一样!
    // 参数2: (NSURLResponse *__autoreleasing *)  NSURLResponse:服务器响应! 两个 ** 先指定一块地址.内容为空!
    // 等方法执行完毕之后,会将返回的内容存储到这块地址中!
    
    NSURLResponse *response = nil;
    NSLog(@"response%@",response);
    
    // 同步请求: 阻塞当前线程!
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    // MIMEType : 就是需要的文件类型!
    // expectedContentLength: 文件的长度/大小!一般在文件下载的时候使用! 类型是 lld (long long)
    // suggestedFilename:  建议的文件名称!
    
    
    NSLog(@"response: %@ %@ %lld", response.MIMEType, response.suggestedFilename, response.expectedContentLength);
    
    return response;
}


@end
