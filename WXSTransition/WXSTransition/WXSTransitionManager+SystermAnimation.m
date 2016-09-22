//
//  WXSTransitionManager+SystermAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+SystermAnimation.h"
#import "WXSTransitionManager+TypeTool.h"



@implementation WXSTransitionManager (SystermAnimation)



-(void)sysTransitionNextAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    [containerView bringSubviewToFront:fromVC.view];
    [containerView bringSubviewToFront:toVC.view];
    
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];
        
    };
    
}

-(void)sysTransitionBackAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        toVC.view.hidden = NO;
        
        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];
    };
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            toVC.view.hidden = NO;
        }else{
            toVC.view.hidden = YES;
            [tempView removeFromSuperview];
            [temView1 removeFromSuperview];
        }
        
    };
    
}

@end
