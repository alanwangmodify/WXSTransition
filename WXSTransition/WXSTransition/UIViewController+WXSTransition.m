

#import "UIViewController+WXSTransition.h"
#import <objc/runtime.h>

static NSString *AnimationTypeKey = @"animationTypeKey";
static NSString *TargetViewKey = @"TargetViewKey";
static NSString *StarViewKey = @"StarViewKey";
static NSString *CallBackTransitionKey = @"CallBackTransitionKey";
static NSString *FromVCInteraciveTransitionKey = @"fromVCInteraciveTransitionKey";
static NSString *ToVCInteraciveTransitionKey = @"ToVCInteraciveTransitionKey";

UINavigationControllerOperation _operation;

@implementation UIViewController (WXSTransition)


#pragma mark Action Method


//Default
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion{

    [self wxs_presentViewController:viewControllerToPresent makeTransition:nil completion:completion];
}

//Choose animation type
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent animationType:(WXSTransitionAnimationType )animationType completion:(void (^)(void))completion{
    
    [self wxs_presentViewController:viewControllerToPresent makeTransition:^(WXSTransitionManager *transition) {
        transition.animationType = animationType;
    } completion:completion];
    
    
}

//make transition
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock{
    
    [self wxs_presentViewController:viewControllerToPresent makeTransition:transitionBlock completion:nil];
    
}

//make transition With Completion
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion{
    
    
    viewControllerToPresent.transitioningDelegate = viewControllerToPresent;
    viewControllerToPresent.animationType = WXSTransitionAnimationTypeDefault;
    viewControllerToPresent.callBackTransition = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    
}


-(void)wxs_addGestureForPresentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion{
    [self wxs_addGestureForPresentViewController:viewControllerToPresent makeTransition:nil completion:completion];
    
}

-(void)wxs_addGestureForPresentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion{

    WXSPercentDrivenInteractiveTransition *fromVCInteraciveTransition = [[WXSPercentDrivenInteractiveTransition alloc] init];
    [fromVCInteraciveTransition addGestureToViewController:self];
    fromVCInteraciveTransition.transitionType = WXSTransitionTypePresent;
     viewControllerToPresent.fromVCInteraciveTransition = self.fromVCInteraciveTransition = fromVCInteraciveTransition;
    
    __weak __typeof (&*self)weakSelf = self;
    fromVCInteraciveTransition.presentBlock = ^(){
       [weakSelf wxs_presentViewController:viewControllerToPresent makeTransition:transitionBlock completion:completion];
    };
    
}

#pragma mark Property

//AnimationType
-(void)setAnimationType:(WXSTransitionAnimationType )animationType {
    objc_setAssociatedObject(self, &AnimationTypeKey, @(animationType), OBJC_ASSOCIATION_ASSIGN);
}
-(WXSTransitionAnimationType)animationType {
    NSInteger type = [objc_getAssociatedObject(self, &AnimationTypeKey) integerValue];
    return (WXSTransitionAnimationType)type;
}

//targtView
-(void)setTargetView:(UIView *)targetView {
    objc_setAssociatedObject(self, &TargetViewKey, targetView, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)targetView{
    return objc_getAssociatedObject(self, &TargetViewKey);
}
//starView
-(void)setStarView:(UIView *)starView {
    objc_setAssociatedObject(self, &StarViewKey, starView, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)starView {
    return objc_getAssociatedObject(self, &StarViewKey);
}

//CallBackTransition
-(void)setCallBackTransition:(WXSTransitionBlock)callBackTransition {
    objc_setAssociatedObject(self, &CallBackTransitionKey, callBackTransition, OBJC_ASSOCIATION_COPY);
}

-(WXSTransitionBlock)callBackTransition{
    return objc_getAssociatedObject(self, &CallBackTransitionKey);
}

//FromVCInteraciveTransitionKey
-(void)setFromVCInteraciveTransition:(WXSPercentDrivenInteractiveTransition *)fromVCInteraciveTransition{
    objc_setAssociatedObject(self, &FromVCInteraciveTransitionKey, fromVCInteraciveTransition, OBJC_ASSOCIATION_RETAIN);
}
-(WXSPercentDrivenInteractiveTransition *)fromVCInteraciveTransition {
    return objc_getAssociatedObject(self, &FromVCInteraciveTransitionKey);
}

//ToVCInteraciveTransition
-(void)setToVCInteraciveTransition:(WXSPercentDrivenInteractiveTransition *)toVCInteraciveTransition {
    objc_setAssociatedObject(self, &ToVCInteraciveTransitionKey, toVCInteraciveTransition, OBJC_ASSOCIATION_RETAIN);
}
-(WXSPercentDrivenInteractiveTransition *)toVCInteraciveTransition{
    return objc_getAssociatedObject(self, &ToVCInteraciveTransitionKey);
}


#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    transtion.transitionType = WXSTransitionTypeDismiss;
    if (transtion.isSysBackAnimation) {
        return nil;
    }
    return transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    transtion.transitionType = WXSTransitionTypePresent;
    [self addBackGestureAccordingTransition:transtion];
    self.toVCInteraciveTransition.transitionType = WXSTransitionTypeDismiss;
    return transtion;
    
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return self.fromVCInteraciveTransition.isInteractive ? self.fromVCInteraciveTransition : nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    //if return nil ,it will dismiss directly
    return self.toVCInteraciveTransition.isInteractive ? self.toVCInteraciveTransition : nil;
}



//  ********************** Push Pop **********************

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    _operation = operation;
    transtion.transitionType = operation == UINavigationControllerOperationPush ? WXSTransitionTypePush : WXSTransitionTypePop;
    
    self.toVCInteraciveTransition.transitionType = WXSTransitionTypePop;
    
    if (transtion.isSysBackAnimation && operation == UINavigationControllerOperationPop) {
        return nil;
    }
    if (operation == UINavigationControllerOperationPush) {
        [self addBackGestureAccordingTransition:transtion];
        self.toVCInteraciveTransition.transitionType = WXSTransitionTypePop;
        __weak __typeof(&*self) weakSelf = self;
        self.toVCInteraciveTransition.popBlock = ^(){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return transtion;
    
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    if (_operation == UINavigationControllerOperationPush) {
        return self.fromVCInteraciveTransition.isInteractive ? self.fromVCInteraciveTransition : nil;
    }else{
        return self.toVCInteraciveTransition.isInteractive ? self.toVCInteraciveTransition : nil;
    }
}


#pragma mark Private Method
-(void)addBackGestureAccordingTransition:(WXSTransitionManager *)transition{

    if (transition.backGestureEnable) {
        WXSPercentDrivenInteractiveTransition *toVCInteraciveTransition = [[WXSPercentDrivenInteractiveTransition alloc] init];
        [toVCInteraciveTransition addGestureToViewController:self];
        toVCInteraciveTransition.getstureType = WXSGestureTypePanRight;
        switch (transition.animationType) {
            case WXSTransitionAnimationTypeDefault:
                break;
            case WXSTransitionAnimationTypePageTransition:
                toVCInteraciveTransition.getstureType = WXSGestureTypePanRight;
                break;
            case WXSTransitionAnimationTypeViewMoveToNextVC:
                break;
            case WXSTransitionAnimationTypeCover:
                break;
            case WXSTransitionAnimationTypeSpreadPresent:
                break;
            case WXSTransitionAnimationTypeBoom:
                
                break;
            default:
                break;
        }
        self.toVCInteraciveTransition = toVCInteraciveTransition;

        
    }
}

#pragma mark Getter

@end
