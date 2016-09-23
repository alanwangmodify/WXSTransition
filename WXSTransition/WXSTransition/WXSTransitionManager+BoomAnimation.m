//
//  WXSTransitionManager+BoomAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+BoomAnimation.h"

@implementation WXSTransitionManager (BoomAnimation)



-(void)boomPresentTransitionNextAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:self.animationTime delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1/0.4 options:0 animations:^{
        tempView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
    }];
    
}

-(void)boomPresentTransitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    UIView *containView = [transitionContext containerView];
    
    
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DIdentity;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        tempView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
            [tempView removeFromSuperview];
            
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            fromVC.view.hidden = YES;
            [tempView removeFromSuperview];
        }
        
    }];
    
    self.willEndInteractiveBlock = ^(BOOL sucess) {
        if (sucess) {
            [tempView removeFromSuperview];
        }else{
        }
    };
    
}


@end
