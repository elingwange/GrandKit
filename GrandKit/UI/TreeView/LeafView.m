//
//  LeafView.m
//  GrandKit
//
//  Created by Evan on 2019/9/4.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "LeafView.h"

@interface LeafView()

@property (nonatomic, strong) UIButton *btnBall;
@property (nonatomic, strong) UILabel *lbDesc;
@property (nonatomic, strong) UIImageView *ivIcon;
@property (nonatomic, strong) UILabel *lbTitle;

@end


@implementation LeafView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.btnBall];
    
    
}

- (UIButton *)btnBall {
    if (!_btnBall) {
        _btnBall = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Size(69), Size(69))];
        [_btnBall setImage:[UIImage imageNamed:@"ic_leaf_big"] forState:UIControlStateNormal];
        [_btnBall addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self animationUpDownWithView:_btnBall];
    }
    return _btnBall;
}

#pragma mark - 随机按钮被点击

- (void)onClick:(UIButton *)sender {
    
    [self animationScaleOnceWithView:sender completion:^{
//        if (self.delegate && [self.delegate respondsToSelector:@selector(seleBtnSender:)]) {
//            [self.delegate seleBtnSender:randomBtn];
//        }
//        [self removeFromSuperview];
    }];
}


- (void)animationScaleOnceWithView:(UIView *)view completion:(void (^)(void))completion {
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CALayer *viewLayer = view.layer;
        CGPoint position = viewLayer.position;
        CGPoint toPoint = CGPointMake(position.x, position.y - 200);

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fromValue = [NSValue valueWithCGPoint:viewLayer.position];
        animation.toValue = [NSValue valueWithCGPoint:toPoint];
        animation.duration = 0.1;
        animation.fillMode = kCAFillModeForwards; //动画结束后是否保持状态
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];// 渐进效果
        [viewLayer addAnimation:animation forKey:@"positionAnimation"];
        
    } completion:^(BOOL finished) {
        
 //       [view removeFromSuperview];
    }];
}

- (void)animationUpDownWithView:(UIView *)view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    uint32_t typeInt = arc4random() % 100;
    CGFloat distanceFloat = 0.0;
    while (distanceFloat == 0) {
        distanceFloat = (6 + (int)(arc4random() % (9 - 7 + 1))) * 100.0 / 101.0;
    }
    if (typeInt % 2 == 0) {
        toPoint = CGPointMake(position.x, position.y - distanceFloat);
    } else {
        toPoint = CGPointMake(position.x, position.y + distanceFloat);
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    CGFloat durationFloat = 0.0;
    while (durationFloat == 0.0) {
        durationFloat = 0.9 + (int)(arc4random() % (100 - 70 + 1)) / 31.0;
    }
    [animation setDuration:durationFloat];
    [animation setRepeatCount:MAXFLOAT];
    
    [viewLayer addAnimation:animation forKey:nil];
}

@end
