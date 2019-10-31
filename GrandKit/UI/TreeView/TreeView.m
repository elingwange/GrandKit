//
//  TreeView.m
//  GrandKit
//
//  Created by Evan on 2019/9/4.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "TreeView.h"

@interface TreeView()

@property (nonatomic, strong) NSMutableArray *arrayPointPoint;

@end


@implementation TreeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (NSMutableArray *)arrayPointPoint {
    if (!_arrayPointPoint) {
        _arrayPointPoint = [NSMutableArray array];
        // 横排
        NSMutableArray *arrayX = [NSMutableArray array];
        int index = 0, x = 0;
        int offsetX = Width / 3;
        while (++index) {
            x = offsetX * (index - 1) + offsetX / 2;
            if (x > Width) break;
            [arrayX addObject:[NSNumber numberWithFloat:x]];
        }
        index = 0;
        // 竖排
        NSMutableArray *arrayY = [NSMutableArray array];
        int treeHeight = (Height - Size(200));
        int offsetY = treeHeight / 3;
        int y = 10;
        while (++index) {
            y = offsetY * (index - 1) + offsetY / 2;
            if (y > treeHeight) break;
            [arrayY addObject:[NSNumber numberWithFloat:y]];
        }
        for (int i = 0; i < [arrayX count]; i++) {
            for (int j = 0; j < [arrayY count]; j++) {
                CGPoint point = CGPointMake([[arrayX objectAtIndex:i] intValue], [[arrayY objectAtIndex:j] intValue]);
                [_arrayPointPoint addObject:[NSValue valueWithCGPoint:point]];
            }
        }
    }
    return _arrayPointPoint;
}

- (void)buildUI {
    
    for (NSValue *value in self.arrayPointPoint) {
        CGPoint point = [value CGPointValue];
        point.x += [self randomOffsetX];
        point.y += [self randomOffsetY];
        LeafView *leaf = [[LeafView alloc]initWithFrame:CGRectMake(0, 0, Size(69), Size(80))];
        leaf.center = point;
        [self addSubview:leaf];
    }
}

- (NSInteger)randomOffsetX {
    CGFloat offset = Size(40);
    NSInteger num = arc4random() % (NSInteger)offset;
    if (num % 2) num = -num;
    return num;
}

- (NSInteger)randomOffsetY {
    CGFloat offset = Size(70);
    NSInteger num = arc4random() % (NSInteger)offset;
    if (num % 2) num = -num;
    return num;
}

@end
