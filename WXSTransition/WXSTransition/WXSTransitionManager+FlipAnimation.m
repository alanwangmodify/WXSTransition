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
    
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    backLayer.backgroundColor = [UIColor blackColor].CGColor;
    backLayer.opacity = 0.4;
    
    
    UIView *flipView = [[UIView alloc] init];
    flipView.frame = CGRectMake(screenWidth/4, screenHeight/3, screenWidth/3, screenHeight/3);
    flipView.center = containView.center;
    
    UIImage *topImg = [self imageFromView:toView atFrame:CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height/2)];
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, flipView.bounds.size.width, flipView.bounds.size.height/2)];
    topView.image = topImg;
    
    
    UIImage *bottomImg = [self imageFromView:toView atFrame:CGRectMake(0, toView.bounds.size.height/2, toView.bounds.size.width, toView.bounds.size.height/2) ];
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, flipView.bounds.size.height/2, flipView.bounds.size.width, flipView.bounds.size.height/2)];
    bottomView.image = bottomImg;
    
    
    //addsubView
    [containView.layer addSublayer:backLayer];
    [containView addSubview:fromView];
    [containView addSubview:flipView];
    [flipView addSubview:topView];
    [flipView addSubview:bottomView];
    
    [transitionContext completeTransition:YES];
    //            _transformView.upperBackLayer.transform = CATransform3DMakeRotation(-M_PI_2, 1.0, 0.0, 0.0);
//    UIView *topView = [[UIView alloc] initWithFrame:<#(CGRect)#>]
    
}
- (void)tipFlipBackAnimationContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}




@end
