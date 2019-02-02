//
//  GKPoint.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/1.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKPoint : NSObject

#pragma mark name
@property (nonatomic,copy) NSString *name;
#pragma mark 类名
@property (nonatomic,copy) NSString *className;

+ (GKPoint *)initWithName:(NSString *)name andClass:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
