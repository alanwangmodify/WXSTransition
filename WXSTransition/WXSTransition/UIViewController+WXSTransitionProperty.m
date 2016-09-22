//
//  UIViewController+WXSTransitionProperty.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/21.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "UIViewController+WXSTransitionProperty.h"
#import <objc/runtime.h>


static NSString *wxs_callBackTransitionKey = @"CallBackTransitionKey";
static NSString *wxs_delegateFlagKey = @"wxs_DelegateFlagKey";
static NSString *wxs_addTransitionFlagKey = @"wxs_addTransitionFlagKey";
static NSString *wxs_transitioningDelegateKey = @"wxs_transitioningDelegateKey";
static NSString *wxs_tempNavDelegateKey = @"wxs_tempNavDelegateKey";



@implementation UIViewController (WXSTransitionProperty)


#pragma mark Property


//----- CallBackTransition
- (void)setWxs_callBackTransition:(WXSTransitionBlock)wxs_callBackTransition {
    objc_setAssociatedObject(self, &wxs_callBackTransitionKey, wxs_callBackTransition, OBJC_ASSOCIATION_COPY);
}
- (WXSTransitionBlock)wxs_callBackTransition {
    return objc_getAssociatedObject(self, &wxs_callBackTransitionKey);
}

//----- wxs_DelegateFlag
- (void)setWxs_delegateFlag:(BOOL)wxs_delegateFlag {
    objc_setAssociatedObject(self, &wxs_delegateFlagKey, @(wxs_delegateFlag), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)wxs_delegateFlag {
    return [objc_getAssociatedObject(self, &wxs_delegateFlagKey) integerValue] == 0 ?  NO : YES;
}


//----- wxs_addTransitionFlag
- (void)setWxs_addTransitionFlag:(BOOL)wxs_addTransitionFlag {
    objc_setAssociatedObject(self, &wxs_addTransitionFlagKey, @(wxs_addTransitionFlag), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)wxs_addTransitionFlag {
    return [objc_getAssociatedObject(self, &wxs_addTransitionFlagKey) integerValue] == 0 ?  NO : YES;
}

//----- Wxs_transitioningDelega
- (void)setWxs_transitioningDelegate:(id)wxs_transitioningDelegate {
    objc_setAssociatedObject(self, &wxs_transitioningDelegateKey, wxs_transitioningDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id)wxs_transitioningDelegate {
    return objc_getAssociatedObject(self, &wxs_transitioningDelegateKey);
}
//----- wxs_tempNavDelegate
- (void)setWxs_tempNavDelegate:(id)wxs_tempNavDelegate {
    objc_setAssociatedObject(self, &wxs_tempNavDelegateKey, wxs_tempNavDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id)wxs_tempNavDelegate {
    return objc_getAssociatedObject(self, &wxs_tempNavDelegateKey);
}

@end
