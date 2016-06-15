//
//  WXSTransitionPropertyMaker.h
//  WXSTransition
//
//  Created by 王小树 on 16/6/14.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXSTypedefConfig.h"

@interface WXSTransitionPropertyMaker : NSObject


@property (nonatomic,assign) NSTimeInterval animationTime;
@property (nonatomic,assign) NSTimeInterval backAnimationTime;
@property (nonatomic,assign) WXSTransitionType transitionType;
@property (nonatomic,assign) WXSTransitionAnimationType animationType;
@property (nonatomic,assign) BOOL backGestureEnable;
@property (nonatomic,assign) WXSGestureType gestureType;
@property (nonatomic,assign) BOOL isSysBackAnimation;


@end
