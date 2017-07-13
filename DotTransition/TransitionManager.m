//
//  TransitionManager.m
//  DotTransition
//
//  Created by CJ on 2017/7/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "TransitionManager.h"
#import "NextViewController.h"
#import "ViewController.h"

@interface TransitionManager () <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic, assign) BOOL presenting;

@end

@implementation TransitionManager

+ (instancetype)transitionManager:(BOOL)presenting {
    return [[self alloc] initWithPresenting:presenting];
}

- (instancetype)initWithPresenting:(BOOL)presenting {
    self = [super init];
    if (self) {
        _presenting = presenting;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.presenting) {
        [self present:transitionContext];
    } else {
        [self dismiss:transitionContext];
    }
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 获取VC
    ViewController * bottomVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NextViewController * nextVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:bottomVC.view];
    [containerView addSubview:nextVC.view];
    // 路径
    CGRect btnFrame = bottomVC.button.frame;
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:btnFrame];
    CGFloat x = MAX(btnFrame.origin.x, containerView.frame.size.width - btnFrame.origin.x);
    CGFloat y = MAX(btnFrame.origin.y, containerView.frame.size.height - btnFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    nextVC.view.layer.mask = maskLayer;
    
    // 动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取VC
    NextViewController * nextVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController * bottomVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:bottomVC.view];
    [containerView addSubview:nextVC.view];
    
    // 路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:bottomVC.button.frame];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    nextVC.view.layer.mask = maskLayer;
    
    // 动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"dotTransition"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_presenting) {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"dotTransition"];
        [transitionContext completeTransition:YES];
    } else {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"dotTransition"];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        }
    }
}

@end
