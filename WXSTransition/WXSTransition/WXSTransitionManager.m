
#import "WXSTransitionManager.h"
#import "UIViewController+WXSTransition.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "WXSTransitionManager+FragmentAnimation.h"
#import "WXSTransitionManager+TypeTool.h"
#import "WXSTransitionManager+BrickAnimation.h"
#import "WXSTransitionManager+SpreadAnimation.h"


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

#pragma mark Delegate
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
#pragma mark Action
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
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];

    [containerView bringSubviewToFront:fromVC.view];
    [containerView bringSubviewToFront:toVC.view];
    
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    _completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];

    };
    
}

-(void)backSysTransitionAnimationWithType:(WXSTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CATransition *tranAnimation = [self getSysTransitionWithType:type];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    _completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        toVC.view.hidden = NO;

        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];
    };
    
    _willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            toVC.view.hidden = NO;
        }else{
            toVC.view.hidden = YES;
            [tempView removeFromSuperview];
            [temView1 removeFromSuperview];
        }
        
    };
    
    
}
#pragma mark Animations
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

    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DIdentity;
        fromVC.view.alpha = 0.2;
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.alpha = 1;
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
            toVC.view.alpha = 1;
        }
    }];
    _willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
            toVC.view.alpha = 1;
        }else{
            fromVC.view.alpha = 1;
        }
    };
    
}


-(void)viewMoveNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
  
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [self.startView convertRect:self.startView.bounds toView: containerView];
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1 / 0.6 options:0 animations:^{
        startView.frame = [weakSelf.targetView convertRect:weakSelf.targetView.bounds toView:containerView];
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        startView.hidden = YES;
        weakSelf.targetView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

    
}
-(void)viewMoveBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    
    [containerView insertSubview:toVC.view atIndex:0];
    
    //Default values
    self.targetView.hidden = YES;
    self.startView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    fromVC.view.alpha = 1;
    tempView.frame = [self.targetView convertRect:self.targetView.bounds toView:fromVC.view];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:0 animations:^{
        
        tempView.frame = [weakSelf.startView convertRect:weakSelf.startView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            
            tempView.hidden = YES;
            weakSelf.targetView.hidden = NO;
            weakSelf.startView.hidden = NO;
            
        }else{
            
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];

        }
        fromVC.view.hidden = NO;

    }];
    
    _willEndInteractiveBlock  = ^(BOOL success){
        
        if (success) {
            
            fromVC.view.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            [tempView removeFromSuperview];
            
        }else{
            tempView.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = NO;
            
        }
    };
    
}

-(void)viewMoveNormalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [self.startView convertRect:self.startView.bounds toView: containerView];
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationTime animations:^{
        startView.frame = [weakSelf.targetView convertRect:weakSelf.targetView.bounds toView:containerView];
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        startView.hidden = YES;
        weakSelf.targetView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}
-(void)viewMoveNormalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;

    
    [containerView insertSubview:toVC.view atIndex:0];
    
    //Default values
    self.targetView.hidden = YES;
    self.startView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    fromVC.view.alpha = 1;
    tempView.frame = [self.targetView convertRect:self.targetView.bounds toView:fromVC.view];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:_animationTime animations:^{
        
        tempView.frame = [weakSelf.startView convertRect:weakSelf.startView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            
            tempView.hidden = YES;
            weakSelf.targetView.hidden = NO;
            weakSelf.startView.hidden = NO;
            
        }else{
            
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
            
        }
        fromVC.view.hidden = NO;
        
    }];
    
    _willEndInteractiveBlock  = ^(BOOL success){
        
        if (success) {
            
            fromVC.view.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            [tempView removeFromSuperview];
            
        }else{
            tempView.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = NO;
            
        }
    };
    
}

-(void)coverNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];

    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
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
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    tempView.hidden = NO;
    tempView.alpha = 1;
    
    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
        tempView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            
            fromVC.view.hidden = NO;
            [transitionContext completeTransition:NO];
            tempView.alpha = 1;

        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;

        }
        [tempView removeFromSuperview];
    }];
    
    _willEndInteractiveBlock = ^(BOOL success){
        
        if (success) {
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];

        }else{
            fromVC.view.hidden = NO;
            tempView.alpha = 1;
            
        }

    };
}


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
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(containerView.center.x - 1, containerView.center.y - 1, 2, 2);
    if (self.startView) {
        CGPoint tempCenter = [self.startView convertPoint:self.startView.center toView:containerView];
        rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = _animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointNextPath"];
    
    _completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            [tempView removeFromSuperview];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
        
    };
    
}
-(void)pointSpreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO]; //YES会导致闪一下

    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(containerView.center.x-1, containerView.center.y-1, 2, 2);
    if (self.startView) {
        CGPoint tempCenter = [self.startView convertPoint:self.startView.center toView:containerView];
        rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = _animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointBackPath"];
    
    _willEndInteractiveBlock = ^(BOOL sucess) {
        if (sucess) {
            maskLayer.path = endPath.CGPath;
        }else{
            maskLayer.path = startPath.CGPath;
        }
    };
    
    _completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        
    };
    
}

-(void)boomPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:_animationTime delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:1/0.4 options:0 animations:^{
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
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    UIView *containView = [transitionContext containerView];
    
    
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    tempView.layer.transform = CATransform3DIdentity;

    [UIView animateWithDuration:_animationTime animations:^{
        tempView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {

            [transitionContext completeTransition:NO];
            fromVC.view.hidden = NO;
            [tempView removeFromSuperview];
            
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            fromVC.view.hidden = YES;
            [tempView removeFromSuperview];
        }
        
    }];
    
    _willEndInteractiveBlock = ^(BOOL sucess) {
        if (sucess) {
            
            [tempView removeFromSuperview];
            
        }else{
            
        }
    };

}

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



-(void)insideThenPushNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    toView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
    [UIView animateWithDuration:_animationTime animations:^{
        
        fromView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
        toView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromView.layer.transform = CATransform3DIdentity;

            
        }else{
            [transitionContext completeTransition:YES];
            fromView.layer.transform = CATransform3DIdentity;
        }
    }];
}

-(void)insideThenPushBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempToView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    toView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
    fromView.layer.transform = CATransform3DIdentity;
    [UIView animateWithDuration:_animationTime animations:^{
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
        
    } completion:^(BOOL finished){
    
        [tempToView removeFromSuperview];
        [containerView addSubview:toVC.view];
        toView.layer.transform = CATransform3DIdentity;
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
    }];
    
    _willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            toView.layer.transform = CATransform3DIdentity;
            fromView.hidden = YES;
            [containerView addSubview:tempToView];
        }else {
            fromView.hidden = NO;
            toView.layer.transform = CATransform3DIdentity;
        }
        
    };
    
}

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


#pragma mark Other



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
