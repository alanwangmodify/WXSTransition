
#import "WXSTransitionManager.h"
#import "UIViewController+WXSTransition.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "WXSTransitionManager+FragmentAnimation.h"
#import "WXSTransitionManager+TypeTool.h"
#import "WXSTransitionManager+BrickAnimation.h"
#import "WXSTransitionManager+SpreadAnimation.h"
#import "WXSTransitionManager+ViewMoveAnimation.h"
#import "WXSTransitionManager+CoverAnimation.h"
#import "WXSTransitionManager+SystermAnimation.h"
#import "WXSTransitionManager+PageAnimation.h"
#import "WXSTransitionManager+BoomAnimation.h"
#import "WXSTransitionManager+InsideThenPushAnimation.h"


@interface WXSTransitionManager ()

@property (nonatomic, assign) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation WXSTransitionManager

-(instancetype)init {
    self = [super init];
    if (self) {
        
        _completionBlock = nil;
        
    }
    return self;
}

#pragma mark - Delegate
//UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _animationTime ;
}

- (void)animationEnded:(BOOL) transitionCompleted {
    
    if (transitionCompleted) {
        [self removeDelegate];
    }
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    _transitionContext = transitionContext;
    if (self.animationType == WXSTransitionAnimationTypeDefault) {
        self.animationType = WXSTransitionAnimationTypeSysPushFromLeft;
    }
    switch (_transitionType) {
        case WXSTransitionTypePush:
        case WXSTransitionTypePresent:
            [self transitionActionAnimation:transitionContext withAnimationType:self.animationType];
            break;
        case WXSTransitionTypePop:
        case WXSTransitionTypeDismiss:
            [self transitionBackAnimation:transitionContext withAnimationType:self.animationType];
            break;
        default:
            break;
    }
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
 
    if (flag) {
        _completionBlock ? _completionBlock() : nil;
        _completionBlock = nil;
    }
    
}
#pragma mark - Action
-(void)transitionActionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    if ((NSInteger)animationType < (NSInteger)WXSTransitionAnimationTypeDefault) {
        [self sysTransitionAnimationWithType:animationType  context:transitionContext];
    }
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList([WXSTransitionManager class], &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"NextTransitionAnimation"].location != NSNotFound) {
            tag++;
            if (tag == animationType - WXSTransitionAnimationTypeDefault) {
                ((void (*)(id,SEL,id<UIViewControllerContextTransitioning>,WXSTransitionAnimationType))objc_msgSend)(self,selector,transitionContext,animationType);
                break;
            }

        }
    }
    free(methodlist);
    
}

-(void)transitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    if ((NSInteger)animationType < (NSInteger)WXSTransitionAnimationTypeDefault) {
        [self backSysTransitionAnimationWithType:_backAnimationType  context:transitionContext];
    }
    
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList([WXSTransitionManager class], &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"BackTransitionAnimation"].location != NSNotFound) {
            tag++;
            if (tag == animationType - WXSTransitionAnimationTypeDefault) {
                ((void (*)(id,SEL,id<UIViewControllerContextTransitioning>,WXSTransitionAnimationType))objc_msgSend)(self,selector,transitionContext,animationType);
                break;
            }
            
        }
    }
    free(methodlist);

}

-(void)sysTransitionAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext{    
    [self sysTransitionNextAnimationWithType:type context:transitionContext];
}

-(void)backSysTransitionAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self sysTransitionBackAnimationWithType:type context:transitionContext];
}
#pragma mark - Animations

// *********************************************************************************************
-(void)pageNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self pageTransitionNextAnimationWithContext:transitionContext];
}
-(void)pageBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self pageTransitionBackAnimationWithContext:transitionContext];
}


// *********************************************************************************************
-(void)viewMoveNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveNextWithType:WXSTransitionAnimationTypeViewMoveToNextVC andContext:transitionContext];
}
-(void)viewMoveBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveBackWithType:WXSTransitionAnimationTypeViewMoveToNextVC andContext:transitionContext];
}
-(void)viewMoveNormalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveNextWithType:WXSTransitionAnimationTypeViewMoveNormalToNextVC andContext:transitionContext];
}
-(void)viewMoveNormalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveBackWithType:WXSTransitionAnimationTypeViewMoveNormalToNextVC andContext:transitionContext];
}


// *********************************************************************************************
-(void)coverNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self coverTransitionNextAnimationWithContext:transitionContext];
}
-(void)coverBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self coverTransitionBackAnimationWithContext:transitionContext];
}



// *********************************************************************************************
-(void)spreadFromRightNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadNextWithType:WXSTransitionAnimationTypeSpreadFromRight andTransitonContext:transitionContext];
}
-(void)spreadFromRightBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadBackWithType:WXSTransitionAnimationTypeSpreadFromRight andTransitonContext:transitionContext];
}
-(void)spreadFromLeftNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadNextWithType:WXSTransitionAnimationTypeSpreadFromLeft andTransitonContext:transitionContext];
}
-(void)spreadFromLeftBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadBackWithType:WXSTransitionAnimationTypeSpreadFromLeft andTransitonContext:transitionContext];
}
-(void)spreadFromTopNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadNextWithType:WXSTransitionAnimationTypeSpreadFromTop andTransitonContext:transitionContext];
}
-(void)spreadFromTopBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadBackWithType:WXSTransitionAnimationTypeSpreadFromTop andTransitonContext:transitionContext];
}
-(void)spreadFromBottomNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadNextWithType:WXSTransitionAnimationTypeSpreadFromBottom andTransitonContext:transitionContext];
}
-(void)spreadFromBottomBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self spreadBackWithType:WXSTransitionAnimationTypeSpreadFromBottom andTransitonContext:transitionContext];
}
-(void)pointSpreadPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self pointSpreadNextWithContext:transitionContext];
}
-(void)pointSpreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self pointSpreadBackWithContext:transitionContext];
}


// *********************************************************************************************
-(void)boomPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self boomPresentTransitionNextAnimation:transitionContext];
}
-(void)boomPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self boomPresentTransitionBackAnimation:transitionContext];
}


// *********************************************************************************************
-(void)brickOpenVerticalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickOpenNextWithType:WXSTransitionAnimationTypeBrickOpenVertical andTransitionContext:transitionContext];
}
-(void)brickOpenVerticalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickOpenBackWithType:WXSTransitionAnimationTypeBrickOpenVertical andTransitionContext:transitionContext];
}
-(void)brickOpenHorizontalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
     [self brickOpenNextWithType:WXSTransitionAnimationTypeBrickOpenHorizontal andTransitionContext:transitionContext];
}
-(void)brickOpenHorizontalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickOpenBackWithType:WXSTransitionAnimationTypeBrickOpenHorizontal andTransitionContext:transitionContext];
}
-(void)brickCloseVerticalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
     [self brickCloseNextWithType:WXSTransitionAnimationTypeBrickCloseVertical andTransitionContext:transitionContext];
}
-(void)brickCloseVerticalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickCloseBackWithType:WXSTransitionAnimationTypeBrickCloseVertical andTransitionContext:transitionContext];
}
-(void)brickCloseHorizontalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickCloseNextWithType:WXSTransitionAnimationTypeBrickCloseHorizontal andTransitionContext:transitionContext];
}
-(void)brickCloseHorizontalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self brickCloseBackWithType:WXSTransitionAnimationTypeBrickCloseHorizontal andTransitionContext:transitionContext];
}


// *********************************************************************************************
-(void)insideThenPushNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self insideThenPushNextAnimationWithContext:transitionContext];
}
-(void)insideThenPushBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self insideThenPushBackAnimationWithContext:transitionContext];
}



// *********************************************************************************************
-(void)fragmentShowFromRightNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowNextType:WXSTransitionAnimationTypeFragmentShowFromRight andContext:transitionContext];
}
-(void)fragmentShowFromRightBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowBackType:WXSTransitionAnimationTypeFragmentShowFromRight andContext:transitionContext];
}
-(void)fragmentShowFromLeftNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowNextType:WXSTransitionAnimationTypeFragmentShowFromLeft andContext:transitionContext];
}
-(void)fragmentShowFromLeftBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowBackType:WXSTransitionAnimationTypeFragmentShowFromLeft andContext:transitionContext];
}
-(void)fragmentShowFromTopNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowNextType:WXSTransitionAnimationTypeFragmentShowFromTop andContext:transitionContext];
}
-(void)fragmentShowFromTopBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowBackType:WXSTransitionAnimationTypeFragmentShowFromTop andContext:transitionContext];
}
-(void)fragmentShowFromBottomNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowNextType:WXSTransitionAnimationTypeFragmentShowFromBottom andContext:transitionContext];
}
-(void)fragmentShowFromBottomBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentShowBackType:WXSTransitionAnimationTypeFragmentShowFromBottom andContext:transitionContext];
}
-(void)fragmentHideFromRightNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideNextType:WXSTransitionAnimationTypeFragmentHideFromRight andContext:transitionContext];
}
-(void)fragmentHideFromRightBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideBackType:WXSTransitionAnimationTypeFragmentHideFromRight andContext:transitionContext];
}
-(void)fragmentHideFromLefttNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideNextType:WXSTransitionAnimationTypeFragmentHideFromLeft andContext:transitionContext];
}
-(void)fragmentHideFromLeftBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideBackType:WXSTransitionAnimationTypeFragmentHideFromLeft andContext:transitionContext];
}
-(void)fragmentHideFromTopNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideNextType:WXSTransitionAnimationTypeFragmentHideFromTop andContext:transitionContext];
}
-(void)fragmentHideFromTopBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideBackType:WXSTransitionAnimationTypeFragmentHideFromTop andContext:transitionContext];
}
-(void)fragmentHideFromBottomNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideNextType:WXSTransitionAnimationTypeFragmentHideFromBottom andContext:transitionContext];
}
-(void)fragmentHideFromBottomBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self fragmentHideBackType:WXSTransitionAnimationTypeFragmentHideFromBottom andContext:transitionContext];
}
// *********************************************************************************************

#pragma mark - Other
- (void)removeDelegate {
    
    UIViewController *fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [_transitionContext containerView];

    void (^RemoveDelegateBlock)() = ^(){
        
        fromVC.transitioningDelegate = nil;
        fromVC.navigationController.delegate = nil;
        toVC.transitioningDelegate = nil;
        toVC.navigationController.delegate = nil;

    };
    
    switch (self.transitionType) {
        case WXSTransitionTypePush:
        case WXSTransitionTypePresent:{ //Next
            if (self.isSysBackAnimation) {
                RemoveDelegateBlock ? RemoveDelegateBlock() : nil;
            }
            containView = nil;
        }
            break;
        default:{ //Back
            RemoveDelegateBlock ? RemoveDelegateBlock() : nil;
            containView = nil;
        }
            break;
    }

}


-(void)setAnimationType:(WXSTransitionAnimationType)animationType {
    _animationType = animationType;
    [self backAnimationTypeFromAnimationType:animationType];
}

+(WXSTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet {
    
    WXSTransitionProperty *propery = object;
    WXSTransitionManager *transition = targetObjcet;
    
    transition.animationTime = propery.animationTime;
    transition.transitionType = propery.transitionType;
    transition.animationType = propery.animationType;
    transition.isSysBackAnimation = propery.isSysBackAnimation;
    transition.backGestureType = propery.backGestureType;
    transition.backGestureEnable = propery.backGestureEnable;
    transition.startView = propery.startView;
    transition.targetView = propery.targetView;
    
    return transition;
    
}

@end
