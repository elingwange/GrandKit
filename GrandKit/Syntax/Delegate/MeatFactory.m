//
//  MeatFactory.m
//  GrandKit
//
//  Created by Evan Fang on 2019/2/13.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "MeatFactory.h"


@implementation MeatFactory

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setBackgroundColor:[UIColor redColor]];
        
        // 监听方法
        [button addTarget:self
                   action:@selector(clickButton)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    return self;
}

- (void)clickButton {
    // 点击按钮的时候就表示， 缺肉了
    NSLog(@"缺猪肉， 赶紧送");
    
    // 通知代理， 调用代理方法
    //    [self.delegate needPigMeet];
    // respondsToSelector:@selector 返回一个bool，如果该对象实现了这个方法，就返回yes，没有实现返回NO
    
#warning 调用代理方法
    if ([self.delegate respondsToSelector:@selector(needMeat)]) {
        [self.delegate needMeat];
    }
}
@end
