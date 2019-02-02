//
//  GKGroup.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/1.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKGroup.h"

@implementation GKGroup

+ (GKGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andPoints:(NSMutableArray *)points {
    GKGroup *group = [[GKGroup alloc]init];
    group.name = name;
    group.detail = detail;
    group.points = points;
    return group;
}

@end
