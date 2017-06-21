

#import "UIViewController+WXSTransition.h"
#import <objc/runtime.h>
#import "UIViewController+WXSTransitionProperty.h"




UINavigationControllerOperation _operation;
WXSPercentDrivenInteractiveTransition *_interactive;
WXSTransitionManager *_transtion;


@implementation UIViewController (WXSTransition)
#pragma mark Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        Method method0 = class_getInstanceMethod(self.class, @selector(wxs_dismissViewControllerAnimated:completion:));
        Method method1 = class_getInstanceMethod(self.class, @selector(dismissViewControllerAnimated:completion:));
        method_exchangeImplementations(method0, method1);
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(wxs_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        BOOL success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
        
        
        originalSelector = @selector(viewWillDisappear:);
        swizzledSelector = @selector(wxs_viewWillDisappear:);
        
        originalMethod = class_getInstanceMethod(self.class, originalSelector);
        swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}



- (void)wxs_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.wxs_delegateFlag) {
        self.transitioningDelegate = self;
        if (self.wxs_transitioningDelegate) {
            self.transitioningDelegate = self.wxs_transitioningDelegate;
        }
    }
    [self wxs_dismissViewControllerAnimated:flag completion:completion];
}

- (void)wxs_viewDidAppear:(BOOL)animated {
    
    [self wxs_viewDidAppear:animated];
}


- (void)wxs_viewWillDisappear:(BOOL)animated {
    [self wxs_viewWillDisappear:animated];

}



#pragma mark Action Method

//Default
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion{
    
    [self wxs_presentViewController:viewControllerToPresent makeTransition:nil completion:completion];
}

//Choose animation type
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent animationType:(WXSTransitionAnimationType )animationType completion:(void (^)(void))completion{
    
    [self wxs_presentViewController:viewControllerToPresent makeTransition:^(WXSTransitionProperty *transition) {
        transition.animationType = animationType;
    } completion:completion];
    
    
}

//make transition
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock{
    
    [self wxs_presentViewController:viewControllerToPresent makeTransition:transitionBlock completion:nil];
    
}

//make transition With Completion
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion{
    
    if (viewControllerToPresent.transitioningDelegate) {
        self.wxs_transitioningDelegate = viewControllerToPresent.transitioningDelegate;
    }
    viewControllerToPresent.wxs_addTransitionFlag = YES;
    viewControllerToPresent.transitioningDelegate = viewControllerToPresent;
    viewControllerToPresent.wxs_callBackTransition = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    
}




#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (!self.wxs_addTransitionFlag) {
        return nil;//dimiss directly
    }
    
    !_transtion ? _transtion = [[WXSTransitionManager alloc] init] : nil ;
    WXSTransitionProperty *make = [[WXSTransitionProperty alloc] init];
    self.wxs_callBackTransition ? self.wxs_callBackTransition(make) : nil;
    _transtion = [WXSTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = WXSTransitionTypeDismiss;
    self.wxs_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (!self.wxs_addTransitionFlag) {
        return nil;//present directly
    }
    
    !_transtion ? _transtion = [[WXSTransitionManager alloc] init] : nil ;
    WXSTransitionProperty *make = [[WXSTransitionProperty alloc] init];
    self.wxs_callBackTransition ? self.wxs_callBackTransition(make) : nil;
    _transtion = [WXSTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = WXSTransitionTypePresent;
    self.wxs_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
    self.wxs_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (!self.wxs_addTransitionFlag) {
        return nil;
    }
    return _interactive.isInteractive ? _interactive : nil ;
}


//  ********************** Push Pop **********************
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!self.wxs_addTransitionFlag) {
        return nil;
    }
    !_transtion ? _transtion = [[WXSTransitionManager alloc] init] : nil ;
    WXSTransitionProperty *make = [[WXSTransitionProperty alloc] init];
    self.wxs_callBackTransition ? self.wxs_callBackTransition(make) : nil;
    _transtion = [WXSTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _operation = operation;

    
    if ( operation == UINavigationControllerOperationPush ) {
        self.wxs_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
        _transtion.transitionType = WXSTransitionTypePush;
        
    }else{
        _transtion.transitionType = WXSTransitionTypePop;
    }
    
    if (_operation == UINavigationControllerOperationPush && _transtion.isSysBackAnimation == NO && _transtion.backGestureEnable) {
        //add gestrue for pop
        !_interactive ? _interactive = [[WXSPercentDrivenInteractiveTransition alloc] init] : nil;
        [_interactive addGestureToViewController:self];
        _interactive.transitionType = WXSTransitionTypePop;
        _interactive.getstureType = _transtion.backGestureType != WXSGestureTypeNone ? _transtion.backGestureType : WXSGestureTypePanRight;
        _interactive.willEndInteractiveBlock = ^(BOOL suceess) {
            _transtion.willEndInteractiveBlock ? _transtion.willEndInteractiveBlock(suceess) : nil;
        };
        
    }
    self.wxs_backGestureEnable =  make.backGestureEnable;
    return _transtion;
    
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if (!self.wxs_addTransitionFlag) {
        return nil;
    }
    !_interactive ? _interactive = [[WXSPercentDrivenInteractiveTransition alloc] init] : nil;
    
    if (_operation == UINavigationControllerOperationPush) {
        return nil;
    }else{
        return _interactive.isInteractive ? _interactive : nil ;
    }

}


@end
