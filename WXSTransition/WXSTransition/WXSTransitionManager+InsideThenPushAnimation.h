//
//  WXSTransitionManager+InsideThenPushAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (InsideThenPushAnimation)
-(void)insideThenPushNextAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)insideThenPushBackAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
