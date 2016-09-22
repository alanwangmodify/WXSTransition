//
//  WXSTransitionManager+SystermAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface  WXSTransitionManager (SystermAnimation)

-(void)sysTransitionNextAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)sysTransitionBackAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
