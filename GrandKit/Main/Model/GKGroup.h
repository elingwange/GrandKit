//
//  GKGroup.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/1.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKGroup : NSObject

#pragma mark 组名
@property (nonatomic, copy) NSString *name;

#pragma mark 分组描述
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSMutableArray *points;


+ (GKGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andPoints:(NSMutableArray *)points;

@end

NS_ASSUME_NONNULL_END
