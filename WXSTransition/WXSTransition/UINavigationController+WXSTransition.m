//
//  UINavigationController+WXSTransition.m
//  WXSTransition
//
//  Created by 王小树 on 16/6/3.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "UINavigationController+WXSTransition.h"
#import <objc/runtime.h>
@implementation UINavigationController (WXSTransition)


#pragma mark Hook
+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method0 = class_getInstanceMethod(self.class, @selector(popViewControllerAnimated:));
        Method method1 = class_getInstanceMethod(self.class, @selector(wxs_popViewControllerAnimated:));
        method_exchangeImplementations(method0, method1);
        
    });
}

#pragma mark Action Method
- (void)wxs_pushViewController:(UIViewController *)viewController {
    
    [self wxs_pushViewController:viewController makeTransition:nil];
 
}

- (void)wxs_pushViewController:(UIViewController *)viewController animationType:(WXSTransitionAnimationType) animationType{
    
    [self wxs_pushViewController:viewController makeTransition:^(WXSTransitionManager *transition) {
        transition.animationType = animationType;
    }];
    
}

- (void)wxs_pushViewController:(UIViewController *)viewController makeTransition:(WXSTransitionBlock) transitionBlock {
    
    self.delegate = viewController;
    viewController.callBackTransition = transitionBlock ? transitionBlock : nil;
    [self pushViewController:viewController animated:YES];
    
}



- (UIViewController *)wxs_popViewControllerAnimated:(BOOL)animated {
    
    if (self.viewControllers.lastObject.wxs_DelegateFlag) {
        self.delegate = self.viewControllers.lastObject;
    }
    return [self wxs_popViewControllerAnimated:animated];
    
}

@end
