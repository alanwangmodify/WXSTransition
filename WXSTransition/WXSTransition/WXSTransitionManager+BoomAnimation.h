//
//  WXSTransitionManager+BoomAnimation.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (BoomAnimation)

-(void)boomPresentTransitionNextAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)boomPresentTransitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
