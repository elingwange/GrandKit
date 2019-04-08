//
//  InputUtil.m
//  GrandKit
//
//  Created by Evan Fang on 2019/3/23.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "InputUtil.h"

@implementation InputUtil

- (BOOL)inputShouldLetterOrNumWithText:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex = @"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/*
 是否同时包含字母和数字
 */
- (BOOL)hasLetterAndNumWithText:(NSString *)text {
    NSString * regex = @"^([0-9]|[a-zA-Z]){8,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:text];
    return result;
}

@end
