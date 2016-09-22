//
//  WXSTransitionManager+ViewMoveAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (ViewMoveAnimation)
- (void)viewMoveNextWithType:(WXSTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)viewMoveBackWithType:(WXSTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;


@end
