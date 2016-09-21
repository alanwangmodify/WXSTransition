//
//  WXSTransitionManager+BrickAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/20.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface  WXSTransitionManager (BrickAnimation)

- (void)brickOpenNextWithType:(WXSTransitionAnimationType)type andTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)brickOpenBackWithType:(WXSTransitionAnimationType)type andTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)brickCloseNextWithType:(WXSTransitionAnimationType)type andTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)brickCloseBackWithType:(WXSTransitionAnimationType)type andTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
