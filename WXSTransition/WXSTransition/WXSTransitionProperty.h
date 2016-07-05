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
@property (nonatomic,assign) WXSTransitionAnimationType animationType;
@property (nonatomic,assign) WXSGestureType backGestureType;
@property (nonatomic,assign) BOOL isSysBackAnimation;


+(void)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;
@end
