//
//  WXSTransitionProperty.h
//  WXSTransition
//
//  Created by 王小树 on 16/7/1.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXSTypedefConfig.h"

@interface WXSTransitionProperty : NSObject



@property (nonatomic,assign) NSTimeInterval animationTime;




@property (nonatomic,assign) WXSTransitionType transitionType;

/**
 *  转场动画类型 
 *
 *  transitiion animation type
 */
@property (nonatomic,assign) WXSTransitionAnimationType animationType;

/**
 *  是否采用系统原生返回方式
 *  set YES to make back action of systerm
 */
@property (nonatomic,assign) BOOL isSysBackAnimation;

/**
 *  是否通过手势返回
 *  set YES to enable gesture for back
 */
@property (nonatomic,assign) BOOL backGestureEnable;

/**
 *  返回上个界面的手势 默认：右滑 ：WXSGestureTypePanRight
 *  choose type of gesture for back , default : WXSGestureTypePanRight
 */
@property (nonatomic,assign) WXSGestureType backGestureType;



@end
