//
//  UIViewController+WXSTransitionProperty.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/21.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXSTransitionProperty;


@interface UIViewController (WXSTransitionProperty)


typedef void(^WXSTransitionBlock)(WXSTransitionProperty *transition);

@property (nonatomic, copy  ) WXSTransitionBlock            wxs_callBackTransition;
@property (nonatomic, assign) BOOL                          wxs_delegateFlag;
@property (nonatomic, assign) BOOL                          wxs_addTransitionFlag;

@property (nonatomic, weak  ) id                            wxs_transitioningDelegate;
@property (nonatomic, weak  ) id                            wxs_tempNavDelegate;


@end
