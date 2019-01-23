//
//  NSString+Com.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/21.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "NSString+Com.h"

@implementation NSString (Com)

+ (bool)isEmpty:(NSString *)string {
    if (string != nil && ![string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}

+ (bool)isNotEmpty:(NSString *)string {
    return ![self isEmpty:string];
}

@end
