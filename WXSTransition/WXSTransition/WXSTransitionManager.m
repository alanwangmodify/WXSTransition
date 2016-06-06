
#import "WXSTransitionManager.h"
#import "UIViewController+WXSTransition.h"

@implementation WXSTransitionManager

-(instancetype)init {
    self = [super init];
    if (self) {
     
        _animationTime = 0.6;
        _animationType = WXSTransitionAnimationTypeDefault;
        
    }
    return self;
}


#pragma mark Delegate
//UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _animationTime;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.toVCInteraciveTransition.direction = WXSGestureDirectionRight; //返回时手势
    
    switch (_transitionType) {
        case WXSTransitionTypePush:
            [self pushAnimation:transitionContext withAnimationType:self.animationType];
            break;
        case WXSTransitionTypePop:
            [self popAnimation:transitionContext withAnimationType:self.animationType];
            break;
        case WXSTransitionTypePresent:
            [self presentAnimation:transitionContext withAnimationType:self.animationType];
            break;
        case WXSTransitionTypeDismiss:
            [self dismissAnimation:transitionContext withAnimationType:self.animationType];
            break;
        default:
            break;
    }
    
}


#pragma mark Action
-(void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    switch (animationType) {
        case WXSTransitionAnimationTypeDefault:{
            
        }
            break;
        case WXSTransitionAnimationTypePageTransition:{
            [self pageNextTransitionAnimation:transitionContext];
        }
            break;
        case WXSTransitionAnimationTypeViewMoveToNextVC:{
            
            [self viewMoveNextTransitionAnimation:transitionContext];
            
        }
            break;
        case WXSTransitionAnimationTypeCover:{
            
            [self coverNextTransitionAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
    
}


-(void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    switch (animationType) {
        case WXSTransitionAnimationTypePageTransition:{
            
            [self pageBackTransitionAnimation:transitionContext];
            
        }
            break;
        case WXSTransitionAnimationTypeViewMoveToNextVC:{
            
            [self viewMoveBackTransitionAnimation:transitionContext];
        
        }
            break;
        case WXSTransitionAnimationTypeCover:{
            
            [self coverBackTransitionAnimation:transitionContext];
        }
        default:
            break;
    }
}



-(void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    
    switch (animationType) {
        case WXSTransitionAnimationTypeDefault:
            
            break;
        case WXSTransitionAnimationTypePageTransition:{
            
            [self pageNextTransitionAnimation:transitionContext];
            
        }
            break;
        case WXSTransitionAnimationTypeViewMoveToNextVC:{
            
            
        }
            break;
        case WXSTransitionAnimationTypeCover:{
//            [self ]
        }
            break;
        case WXSTransitionAnimationTypeSpreadPresent:{
            [self spreadPresentNextTransitionAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
    
}
-(void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
    switch (animationType) {
            
        case WXSTransitionAnimationTypePageTransition:{
            
            [self pageBackTransitionAnimation:transitionContext];
            
        }
            break;
        case WXSTransitionAnimationTypeViewMoveToNextVC:{
            
            [self viewMoveBackTransitionAnimation:transitionContext];
            
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark Animations
//
-(void)pageNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    [containerView insertSubview:toVC.view atIndex:0];
    
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    CGPoint point = CGPointMake(0, 0.5);
    tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
    tempView.layer.anchorPoint = point;
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    containerView.layer.sublayerTransform = transfrom3d;
    
    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        
    } completion:^(BOOL finished) {
                
        if ([transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
    }];

    
    
}
-(void)pageBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    fromVC.view.alpha = 0.8;
    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.alpha = 0.2;
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
            fromVC.view.alpha = 1;
            [tempView removeFromSuperview];
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
            toVC.view.alpha = 1;
            toVC.navigationController.delegate = nil;
        }
    }];
    
}


-(void)viewMoveNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [toVC.starView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
  
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [toVC.starView convertRect:toVC.starView.bounds toView: containerView];
    toVC.view.alpha = 0;
    toVC.starView.hidden = NO;
    toVC.targetView.hidden = YES;
    fromVC.view.alpha = 1;

    
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1 / 0.6 options:0 animations:^{
        startView.frame = [toVC.targetView convertRect:toVC.targetView.bounds toView:containerView];
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        startView.hidden = YES;
        toVC.targetView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

    
}
-(void)viewMoveBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    toVC.starView = fromVC.targetView;
    toVC.targetView = fromVC.starView;
    
    [containerView insertSubview:toVC.view atIndex:0];
    
    //Default values
    toVC.starView.hidden = YES;
    toVC.targetView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    fromVC.view.alpha = 1;
    tempView.frame = [fromVC.targetView convertRect:fromVC.targetView.bounds toView:fromVC.view];
    
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:0 animations:^{
        
        tempView.frame = [toVC.targetView convertRect:toVC.targetView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            
            tempView.hidden = YES;
            toVC.targetView.hidden = NO;
            toVC.starView.hidden = NO;
            
        }else{
            
            toVC.targetView.hidden = NO;
            toVC.starView.hidden = YES;
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
}

//
-(void)coverNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];

    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DMakeScale(2, 2, 1);
    tempView.alpha = 0.1;
    tempView.hidden = NO;
    
    [UIView animateWithDuration:_animationTime animations:^{
        
        tempView.layer.transform = CATransform3DIdentity;
        tempView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            toVC.view.hidden = YES;
            [transitionContext completeTransition:NO];
        }else{
            toVC.view.hidden = NO;
            [transitionContext completeTransition:YES];
        }
        [tempView removeFromSuperview];
        
    }];
}

-(void)coverBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    UIView *toTempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView addSubview:toTempView];
    [containView addSubview:tempView];
    
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    tempView.hidden = NO;
    tempView.alpha = 1;
    
    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DMakeScale(2, 2, 1);
        tempView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [tempView removeFromSuperview];
        [toTempView removeFromSuperview];
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            tempView.alpha = 1;
            tempView.layer.transform = CATransform3DIdentity;

        }else{
            
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;

        }
    }];
    
    
}



-(void)spreadPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    toVC.view.hidden = YES;
    tempView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1/0.6 options:0 animations:^{
        
        tempView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
    }];
    
}

-(void)spreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}


-(void)pointSpreadPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
}
-(void)pointSpreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
}

-(void)boomPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    toVC.view.hidden = YES;
    tempView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
    
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1/0.7 options:0 animations:^{
        
        tempView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];

        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
    }];
    
}

-(void)boomPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = NO;
    tempView.layer.transform = CATransform3DIdentity;

    [UIView animateWithDuration:_animationTime animations:^{
       
        tempView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        
    }];

}
@end
