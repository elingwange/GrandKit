//
//  MeatFactory.h
//  GrandKit
//
//  Created by Evan Fang on 2019/2/13.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning 指定协议及代理方法
@protocol MeatFactoryDelegate <NSObject>

- (void)needMeat;

@end


@interface MeatFactory : UIView

@property (nonatomic, weak) id<MeatFactoryDelegate> delegate;

@end
