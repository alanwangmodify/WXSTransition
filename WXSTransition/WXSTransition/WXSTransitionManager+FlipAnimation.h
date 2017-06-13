//
//  WXSTransitionManager+FlipAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 2017/6/12.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (FlipAnimation)

- (void)tipFlipToNextAnimationContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)tipFlipBackAnimationContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
