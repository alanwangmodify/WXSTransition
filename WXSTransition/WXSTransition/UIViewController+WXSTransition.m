

#import "UIViewController+WXSTransition.h"
#import <objc/runtime.h>

static NSString *wxs_animationTypeKey = @"animationTypeKey";
static NSString *wxs_targetViewKey = @"TargetViewKey";
static NSString *wxs_startViewKey = @"startViewKey";
static NSString *wxs_callBackTransitionKey = @"CallBackTransitionKey";
static NSString *wxs_fromVCInteraciveTransitionKey = @"fromVCInteraciveTransitionKey";
static NSString *wxs_toVCInteraciveTransitionKey = @"ToVCInteraciveTransitionKey";
static NSString *wxs_delegateFlagKey = @"wxs_DelegateFlagKey";
static NSString *wxs_addTransitionFlagKey = @"wxs_addTransitionFlagKey";
static NSString *wxs_transitioningDelegateKey = @"wxs_transitioningDelegateKey";
static NSString *wxs_tempNavDelegateKey = @"wxs_tempNavDelegateKey";



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
    });
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
    viewControllerToPresent.wxs_animationType = WXSTransitionAnimationTypeDefault;
    viewControllerToPresent.wxs_callBackTransition = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    
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

#pragma mark Property

//----- wxs_animationType
- (void)setWxs_animationType:(WXSTransitionAnimationType)wxs_animationType {
    objc_setAssociatedObject(self, &wxs_animationTypeKey, @(wxs_animationType), OBJC_ASSOCIATION_ASSIGN);
}

- (WXSTransitionAnimationType)wxs_animationType {
    NSInteger type = [objc_getAssociatedObject(self, &wxs_animationTypeKey) integerValue];
    return (WXSTransitionAnimationType)type;
}

//----- wxs_targetView

- (void)setWxs_targetView:(UIView *)wxs_targetView {
    objc_setAssociatedObject(self, &wxs_targetViewKey, wxs_targetView, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)wxs_targetView{
    return objc_getAssociatedObject(self, &wxs_targetViewKey);
}

//----- startView
- (void)setWxs_startView:(UIView *)wxs_startView {
    objc_setAssociatedObject(self, &wxs_startViewKey, wxs_startView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)wxs_startView {
    return objc_getAssociatedObject(self, &wxs_startViewKey);
}


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

- (BOOL)wxs_transitioningDelegate {
    return objc_getAssociatedObject(self, &wxs_transitioningDelegateKey);
}
//----- wxs_tempNavDelegate
- (void)setWxs_tempNavDelegate:(id)wxs_tempNavDelegate {
    objc_setAssociatedObject(self, &wxs_tempNavDelegateKey, wxs_tempNavDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id)wxs_tempNavDelegate {
    return objc_getAssociatedObject(self, &wxs_tempNavDelegateKey);
}


#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (!self.wxs_addTransitionFlag) {
        return nil;
    }
    
    !_transtion ? _transtion = [[WXSTransitionManager alloc] init] : nil ;
    _transtion.animationType = [self wxs_animationType];
    WXSTransitionProperty *make = [[WXSTransitionProperty alloc] init];
    self.wxs_callBackTransition ? self.wxs_callBackTransition(make) : nil;
    _transtion = [WXSTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = WXSTransitionTypeDismiss;
    
    return _transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (!self.wxs_addTransitionFlag) {
        return nil;
    }
    
    !_transtion ? _transtion = [[WXSTransitionManager alloc] init] : nil ;
    _transtion.animationType = [self wxs_animationType];
    WXSTransitionProperty *make = [[WXSTransitionProperty alloc] init];
    self.wxs_callBackTransition ? self.wxs_callBackTransition(make) : nil;
    _transtion = [WXSTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = WXSTransitionTypePresent;
    self.wxs_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
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
    _transtion.animationType = [self wxs_animationType];
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
