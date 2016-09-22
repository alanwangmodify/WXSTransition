//
//  WXSTransitionProperty.m
//  WXSTransition
//
//  Created by 王小树 on 16/7/1.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionProperty.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation WXSTransitionProperty

-(instancetype)init {
    self = [super init];
    if (self) {
        
        _animationTime = 0.400082;
        self.animationType = WXSTransitionAnimationTypeDefault;
        _backGestureType = WXSGestureTypePanRight;
        _backGestureEnable = YES;
        
    }
    return self;
}

@end
