//
//  GKPoint.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/1.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKPoint.h"

@implementation GKPoint

+ (GKPoint *)initWithName:(NSString *)name andClass:(NSString *)className {
    GKPoint *point = [[GKPoint alloc]init];
    point.name = name;
    point.className = className;
    return point;
}

@end
