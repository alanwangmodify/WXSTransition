//
//  WXSTransitionManager+FlipAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 2017/6/12.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "WXSTransitionManager+FlipAnimation.h"

@implementation WXSTransitionManager (FlipAnimation)
- (void)tipFlipToNextAnimationContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    

    UIImage *topImg = [self imageFromView:toView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *topView = [[UIImageView alloc] initWithImage:topImg];
    [topView setContentMode:UIViewContentModeScaleAspectFill];
    topView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0);
    topView.layer.doubleSided = NO;
    
    UIImage *fromImgTop = [self imageFromView:fromView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *fromTopView = [[UIImageView alloc] initWithImage:fromImgTop];
    fromTopView.backgroundColor = [UIColor clearColor];
    fromTopView.layer.doubleSided = NO;
    
    UIImage *fromImgBottom = [self imageFromView:fromView atFrame:CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2)];
    UIImageView *fromBottomView = [[UIImageView alloc] initWithImage:fromImgBottom];
    fromBottomView.layer.doubleSided = NO;
    
    //addsubView
   
    [containView addSubview:toView];
    [containView addSubview:fromTopView];
    [containView addSubview:topView];
    fromTopView.alpha = 0.0;
    [containView addSubview:fromBottomView];
    fromTopView.alpha = 1.0;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        fromBottomView.layer.transform = CATransform3DMakeRotation(- M_PI, 1.0, 0.0, 0.0);
        topView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [fromTopView removeFromSuperview];
        [fromBottomView removeFromSuperview];
        [topView removeFromSuperview];
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else {
            [containView bringSubviewToFront:toView];
            [transitionContext completeTransition:YES];
        }
        
    }];
}
- (void)tipFlipBackAnimationContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    UIImage *topImg = [self imageFromView:toView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *topView = [[UIImageView alloc] initWithImage:topImg];
    [topView setContentMode:UIViewContentModeScaleAspectFill];
    topView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0);
    topView.layer.doubleSided = NO;
    
    UIImage *fromImgTop = [self imageFromView:fromView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *fromTopView = [[UIImageView alloc] initWithImage:fromImgTop];
    fromTopView.backgroundColor = [UIColor clearColor];
    fromTopView.layer.doubleSided = NO;
    
    UIImage *fromImgBottom = [self imageFromView:fromView atFrame:CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2)];
    UIImageView *fromBottomView = [[UIImageView alloc] initWithImage:fromImgBottom];
    fromBottomView.layer.doubleSided = NO;
    
    //addsubView
    
    [containView addSubview:toView];
    [containView addSubview:fromTopView];
    [containView addSubview:topView];
    fromTopView.alpha = 0.0; //等fromBottomView 遮盖住 fromTopView 再显示fromTopView
    [containView addSubview:fromBottomView];
    fromTopView.alpha = 1.0;
    
    [UIView animateWithDuration:self.animationTime animations:^{
        fromBottomView.layer.transform = CATransform3DMakeRotation(- M_PI, 1.0, 0.0, 0.0);
        topView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [fromTopView removeFromSuperview];
        [fromBottomView removeFromSuperview];
        [topView removeFromSuperview];
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else {
            [containView bringSubviewToFront:toView];
            [transitionContext completeTransition:YES];
        }
        
    }];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            [fromTopView removeFromSuperview];
            [fromBottomView removeFromSuperview];
            [topView removeFromSuperview];
        }
    };
    
}




@end
