

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



#pragma mark Property

//----- AnimationType
-(void)setAnimationType:(WXSTransitionAnimationType )animationType {
    objc_setAssociatedObject(self, &AnimationTypeKey, @(animationType), OBJC_ASSOCIATION_ASSIGN);
}
-(WXSTransitionAnimationType)animationType {
    NSInteger type = [objc_getAssociatedObject(self, &AnimationTypeKey) integerValue];
    return (WXSTransitionAnimationType)type;
}

//----- targtView
-(void)setTargetView:(UIView *)targetView {
    objc_setAssociatedObject(self, &TargetViewKey, targetView, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)targetView{
    return objc_getAssociatedObject(self, &TargetViewKey);
}
//----- starView
-(void)setStarView:(UIView *)starView {
    objc_setAssociatedObject(self, &StarViewKey, starView, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)starView {
    return objc_getAssociatedObject(self, &StarViewKey);
}

//----- CallBackTransition
-(void)setCallBackTransition:(WXSTransitionBlock)callBackTransition {
    objc_setAssociatedObject(self, &CallBackTransitionKey, callBackTransition, OBJC_ASSOCIATION_COPY);
}
-(WXSTransitionBlock)callBackTransition{
    return objc_getAssociatedObject(self, &CallBackTransitionKey);
}




#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    transtion.transitionType = WXSTransitionTypeDismiss;
    return transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    transtion.transitionType = WXSTransitionTypePresent;
//    self.toVCInteraciveTransition.transitionType = WXSTransitionTypeDismiss;
    return transtion;
    
}




//  ********************** Push Pop **********************

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    WXSTransitionManager *transtion = [[WXSTransitionManager alloc] init];
    transtion.animationType = [self animationType];
    self.callBackTransition ? self.callBackTransition(transtion) : nil;
    _operation = operation;
    transtion.transitionType = operation == UINavigationControllerOperationPush ? WXSTransitionTypePush : WXSTransitionTypePop;
    return transtion;
    
}




@end
