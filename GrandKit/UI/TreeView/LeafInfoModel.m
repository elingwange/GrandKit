//
//  LeafInfoModel.m
//  GrandKit
//
//  Created by Evan on 2019/9/6.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "LeafInfoModel.h"

@implementation LeafInfoModel

+ (LeafInfoModel *)mock {
    LeafInfoModel *model = [LeafInfoModel new];
    model.type = 1;
    model.amount = 3;
    model.coinName = @"CK";
    model.title = @"阅读文章";
    model.iconUrl = @"https://s2.ax1x.com/2019/09/06/nuXGrD.png";
    return model;
}

@end
