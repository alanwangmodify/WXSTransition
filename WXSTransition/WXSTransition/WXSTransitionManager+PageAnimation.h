//
//  WXSTransitionManager+PageAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (PageAnimation) 


-(void)pageTransitionNextAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)pageTransitionBackAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
