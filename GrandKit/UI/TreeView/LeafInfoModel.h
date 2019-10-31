//
//  LeafInfoModel.h
//  GrandKit
//
//  Created by Evan on 2019/9/6.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeafInfoModel : NSObject

@property (nonatomic, assign) NSInteger type; //类型
@property (nonatomic, assign) NSInteger amount; //数量
@property (nonatomic, strong) NSString *coinName; //币种名称(ck,btc..)
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconUrl; //https://s2.ax1x.com/2019/09/06/nuXGrD.png

//- (void)setLeafInfoModel;

+ (LeafInfoModel *)mock;

@end

NS_ASSUME_NONNULL_END
