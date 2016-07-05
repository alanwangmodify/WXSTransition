//
//  UINavigationController+WXSTransition.h
//  WXSTransition
//
//  Created by 王小树 on 16/6/3.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"
#import "UIViewController+WXSTransition.h"


@interface UINavigationController (WXSTransition)


- (void)wxs_pushViewController:(UIViewController *)viewController animationType:(WXSTransitionAnimationType) animationType;
- (void)wxs_pushViewController:(UIViewController *)viewController makeTransition:(WXSTransitionBlock) transitionBlock;


@end
