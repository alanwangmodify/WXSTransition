//
//  WXSTransitionManager+SpreadAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/21.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface  WXSTransitionManager (SpreadAnimation)<CAAnimationDelegate>
- (void)spreadNextWithType:(WXSTransitionAnimationType)type andTransitonContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)spreadBackWithType:(WXSTransitionAnimationType)type andTransitonContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pointSpreadNextWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pointSpreadBackWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
