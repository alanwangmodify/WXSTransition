//
//  WXSTransitionManager+SpreadAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/21.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+SpreadAnimation.h"

@implementation WXSTransitionManager (SpreadAnimation)


- (void)spreadNextWithType:(WXSTransitionAnimationType)type andTransitonContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect0 ;
    CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
    switch (type) {
        case WXSTransitionAnimationTypeSpreadFromRight:
            rect0 = CGRectMake(screenWidth, 0, 2, screenHeight);
            break;
        case WXSTransitionAnimationTypeSpreadFromLeft:
            rect0 = CGRectMake(0, 0, 2, screenHeight);
            break;
        case WXSTransitionAnimationTypeSpreadFromTop:
            rect0 = CGRectMake(0, 0, screenWidth, 2);
            break;
        default:
            rect0 = CGRectMake(0, screenHeight , screenWidth, 2);
            break;
    }
    
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath; //动画结束后的值
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.animationTime;
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@"NextPath"];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            
            [transitionContext completeTransition:YES];
        }
        [tempView removeFromSuperview];
    };
    
}
- (void)spreadBackWithType:(WXSTransitionAnimationType)type andTransitonContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 ;
    CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
    
    
    switch (type) {
        case WXSTransitionAnimationTypeSpreadFromRight:
            rect0 = CGRectMake(0, 0, 2, screenHeight);
            break;
        case WXSTransitionAnimationTypeSpreadFromLeft:
            rect0 = CGRectMake(screenWidth-2, 0, 2, screenHeight);
            break;
        case WXSTransitionAnimationTypeSpreadFromTop:
            rect0 = CGRectMake(0, screenHeight - 2 , screenWidth, 2);
            break;
            
        default:
            rect0 = CGRectMake(0, 0, screenWidth, 2);
            break;
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    tempView.layer.mask = maskLayer;
    maskLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"BackPath"];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            maskLayer.path = endPath.CGPath;
            
        }else{
            maskLayer.path = startPath.CGPath;
        }
        
    };
    
    self.completionBlock = ^(){
        
        [tempView removeFromSuperview];
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        
    };
    
}

- (void)pointSpreadNextWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(containerView.center.x - 1, containerView.center.y - 1, 2, 2);
    if (self.startView) {
        CGPoint tempCenter = [self.startView convertPoint:self.startView.center toView:containerView];
        rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointNextPath"];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            [tempView removeFromSuperview];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
        
    };
}
- (void)pointSpreadBackWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO]; //YES会导致闪一下
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(containerView.center.x-1, containerView.center.y-1, 2, 2);
    if (self.startView) {
        CGPoint tempCenter = [self.startView convertPoint:self.startView.center toView:containerView];
        rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointBackPath"];
    
    self.willEndInteractiveBlock = ^(BOOL sucess) {
        if (sucess) {
            maskLayer.path = endPath.CGPath;
        }else{
            maskLayer.path = startPath.CGPath;
        }
    };
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        
    };
    
}

@end
