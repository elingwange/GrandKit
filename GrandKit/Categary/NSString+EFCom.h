//
//  NSString+Com.h
//  GrandKit
//
//  Created by Evan Fang on 2019/1/21.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EFCom)

+ (bool)isEmpty:(NSString *)string;

+ (bool)isNotEmpty:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
