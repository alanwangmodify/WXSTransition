//
//  WXSTransitionManager+FragmentAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/20.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+FragmentAnimation.h"

@implementation WXSTransitionManager (FragmentAnimation)

-(void)fragmentShowNextType:(WXSTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *toVCTempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
    
    CGSize size = fromVC.view.frame.size;
    CGFloat fragmentWidth = 20.0f;
    
    NSInteger rowNum = size.width/fragmentWidth + 1;
    for (int i = 0; i < rowNum ; i++) {
        
        for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
            
            CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
            UIView *fragmentView = [toVCTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            [containerView addSubview:fragmentView];
            [fragmentViews addObject:fragmentView];
            fragmentView.frame = rect;
            switch (type) {
                case WXSTransitionAnimationTypeFragmentShowFromRight:
                    fragmentView.layer.transform = CATransform3DMakeTranslation( random()%50 *50, 0, 0);
                    
                    break;
                case WXSTransitionAnimationTypeFragmentShowFromLeft:
                    fragmentView.layer.transform = CATransform3DMakeTranslation( - random()%50 *50, 0 , 0);
                    
                    break;
                case WXSTransitionAnimationTypeFragmentShowFromTop:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(0, - random()%50 *50, 0);
                    
                    break;
                    
                default:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(0, random()%50 *50, 0);
                    
                    break;
            }
            fragmentView.alpha = 0;
        }
        
    }
    
    
    [UIView animateWithDuration:self.animationTime animations:^{
        for (UIView *fragmentView in fragmentViews) {
            fragmentView.layer.transform = CATransform3DIdentity;
            fragmentView.alpha = 1;
            
        }
    } completion:^(BOOL finished) {
        for (UIView *fragmentView in fragmentViews) {
            [fragmentView removeFromSuperview];
        }
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
        }else{
            [transitionContext completeTransition:YES];
            fromVC.view.hidden = NO;
        }
        
    }];
}
-(void)fragmentShowBackType:(WXSTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:toVC.view];
    
    NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
    
    CGSize size = fromVC.view.frame.size;
    CGFloat fragmentWidth = 20.0f;
    
    NSInteger rowNum = size.width/fragmentWidth + 1;
    for (int i = 0; i < rowNum ; i++) {
        
        for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
            
            CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
            UIView *fragmentView = [fromTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            [containerView addSubview:fragmentView];
            [fragmentViews addObject:fragmentView];
            fragmentView.frame = rect;
        }
        
    }
    
    toVC.view.hidden = NO;
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        for (UIView *fragmentView in fragmentViews) {
            
            CGRect rect = fragmentView.frame;
            
            switch (type) {
                case WXSTransitionAnimationTypeFragmentShowFromRight:
                    rect.origin.x = rect.origin.x + random()%50 *50;
                    break;
                case WXSTransitionAnimationTypeFragmentShowFromLeft:
                    rect.origin.x = rect.origin.x - random()%50 *50;
                    
                    break;
                case WXSTransitionAnimationTypeFragmentShowFromTop:
                    rect.origin.y = rect.origin.y - random()%50 *50;
                    break;
                    
                default:
                    rect.origin.y = rect.origin.y + random()%50 *50;
                    
                    break;
            }
            
            fragmentView.frame = rect;
            fragmentView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        for (UIView *fragmentView in fragmentViews) {
            [fragmentView removeFromSuperview];
        }
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
        }else{
            [transitionContext completeTransition:YES];
            fromVC.view.hidden = NO;
        }
        
    }];
    
    self.willEndInteractiveBlock = ^(BOOL sucess) {
        
        if (sucess) {
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            
        }else{
        }
        
    };
    
    
    
}

-(void)fragmentHideNextType:(WXSTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:toVC.view];
    
    NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
    
    CGSize size = fromVC.view.frame.size;
    CGFloat fragmentWidth = 20.0f;
    
    NSInteger rowNum = size.width/fragmentWidth + 1;
    for (int i = 0; i < rowNum ; i++) {
        
        for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
            
            CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
            UIView *fragmentView = [fromTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            [containerView addSubview:fragmentView];
            [fragmentViews addObject:fragmentView];
            fragmentView.frame = rect;
        }
        
    }
    
    toVC.view.hidden = NO;
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        for (UIView *fragmentView in fragmentViews) {
            CGRect rect = fragmentView.frame;
            switch (type) {
                case WXSTransitionAnimationTypeFragmentHideFromRight:
                    rect.origin.x = rect.origin.x - random()%50 *50;
                    break;
                case WXSTransitionAnimationTypeFragmentHideFromLeft:
                    rect.origin.x = rect.origin.x + random()%50 *50;
                    break;
                case WXSTransitionAnimationTypeFragmentHideFromTop:
                    rect.origin.y = rect.origin.y + random()%50 *50;
                    break;
                default:
                    rect.origin.y = rect.origin.y - random()%50 *50;
                    break;
            }
            fragmentView.frame = rect;
            fragmentView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        
        for (UIView *fragmentView in fragmentViews) {
            [fragmentView removeFromSuperview];
        }
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
        }else{
            [transitionContext completeTransition:YES];
            fromVC.view.hidden = NO;
        }
        
    }];
    
}
-(void)fragmentHideBackType:(WXSTransitionAnimationType)type andContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
    CGSize size = fromVC.view.frame.size;
    CGFloat fragmentWidth = 20.0f;
    
    NSInteger rowNum = size.width/fragmentWidth + 1;
    for (int i = 0; i < rowNum ; i++) {
        
        for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
            
            CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
            UIView *fragmentView = [toVC.view resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            [containerView addSubview:fragmentView];
            [fragmentViews addObject:fragmentView];
            fragmentView.frame = rect;
            switch (type) {
                case WXSTransitionAnimationTypeFragmentHideFromRight:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(-random()%50 *50, 0, 0);
                    break;
                case WXSTransitionAnimationTypeFragmentHideFromLeft:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(random()%50 *50, 0, 0);
                    break;
                case WXSTransitionAnimationTypeFragmentHideFromTop:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(0, random()%50 *50, 0);
                    break;
                default:
                    fragmentView.layer.transform = CATransform3DMakeTranslation(0, -random()%50 *50, 0);
                    break;
            }
            fragmentView.alpha = 0;
        }
        
    }
    
    toVC.view.hidden = YES;
    fromVC.view.hidden = NO;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        
        for (UIView *fragmentView in fragmentViews) {
            fragmentView.alpha = 1;
            fragmentView.layer.transform = CATransform3DIdentity;
        }
    } completion:^(BOOL finished) {
        for (UIView *fragmentView in fragmentViews) {
            [fragmentView removeFromSuperview];
        }
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        toVC.view.hidden = NO;
        
    }];
    
    self.willEndInteractiveBlock = ^(BOOL sucess) {
        if (sucess) {
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            toVC.view.hidden = NO;
        }else{
            
        }
    };
    
}
@end
