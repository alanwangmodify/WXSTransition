
#import "WXSTransitionManager.h"
#import "UIViewController+WXSTransition.h"
@interface WXSTransitionManager ()

@property (nonatomic,copy) void(^completionBlock)();

@end


@implementation WXSTransitionManager

-(instancetype)init {
    self = [super init];
    if (self) {
     
        _animationTime = 0.7;
        _animationType = WXSTransitionAnimationTypeDefault;
        _completionBlock = nil;
        
    }
    return self;
}


#pragma mark Delegate
//UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _animationTime - 0.5;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    if (_animationType == WXSTransitionAnimationTypeDefault) {
        
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
    }
    
}
#pragma mark Action
-(void)transitionActionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
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
        case WXSTransitionAnimationTypeSpreadPresent:{
            [self spreadPresentNextTransitionAnimation:transitionContext];
        }
            break;
        case WXSTransitionAnimationTypeBoom:{
            [self boomPresentNextTransitionAnimation:transitionContext];
        }
            break;
        case WXSTransitionAnimationTypeBrick:{
            [self brickNextTransitionAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
    
}

-(void)transitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(WXSTransitionAnimationType )animationType{
    
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
            break;
        case WXSTransitionAnimationTypeSpreadPresent:
            [self spreadPresentBackTransitionAnimation:transitionContext];
            break;
        case WXSTransitionAnimationTypeBoom:
            [self boomPresentBackTransitionAnimation:transitionContext];
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
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2*0.8, 0, 1, 0);
        
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
            //remove delegate of last view controller from self.
            toVC.navigationController.delegate = nil;
            toVC.transitioningDelegate = nil;        }
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
            //remove delegate of last view controller from self.
            toVC.navigationController.delegate = nil;
            toVC.transitioningDelegate = nil;
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
        tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
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
            //remove delegate of last view controller from self.
            toVC.navigationController.delegate = nil;
            toVC.transitioningDelegate = nil;
        }
    }];
    
    
}



-(void)spreadPresentNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{


    
}

-(void)spreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    

    
    
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
    
    
    CGRect rect = CGRectMake(containerView.center.x, containerView.center.y, 10, 10);
    if (fromVC.starView) {
        rect = fromVC.starView.frame;
    }
    
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = startPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = _animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"NextPath"];
    
    
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
-(void)pointSpreadPresentBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(containerView.center.x, containerView.center.y, 10, 10);
    if (toVC.starView) {
        rect = toVC.starView.frame;
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = startPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = _animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"BackPath"];
    
    
    _completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            toVC.navigationController.delegate = nil;
            toVC.transitioningDelegate = nil;
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
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
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
            fromVC.view.hidden = YES;
        }
        [tempView removeFromSuperview];
        
    }];

}

-(void)brickNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{

    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *toTempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = [transitionContext containerView];
    UIView *tempView0 = [[UIView alloc] init];
    UIView *tempView1 = [[UIView alloc] init];
    
    [containView addSubview:fromTempView];
    [containView addSubview:toTempView];
    [containView addSubview:tempView0];
    [containView addSubview:tempView1];
    [tempView0 addSubview:fromTempView];
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 = CGRectMake(0 , 0 , screenWidth, screenHeight/2);
    CGRect rect1 = CGRectMake(0 , screenHeight/2 , screenWidth, screenHeight/2);
    
    
    CALayer *layer = [CALayer layer];
    
    tempView0.frame = rect0;
    tempView1.frame = rect1;
    
    
    UIImage *image0 = [self imageFromView:fromVC.view atFrame:rect0];
    UIImage *image1 = [self imageFromView:fromVC.view atFrame:rect1];
    
    UIImageView *imgView0 = [[UIImageView alloc] initWithImage:image0];
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:image1];
    
    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView addSubview:imgView0];
    [containView addSubview:imgView1];
    
    [imgView0 convertRect:rect0 toView:containView];
    [imgView1 convertRect:rect1 toView:containView];
    
    [UIView animateWithDuration:_animationTime animations:^{
//        imgView0.layer.transform = CATransform3DMakeRotation(-M_PI_2, 1, 1, 0);
        
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
    }];
    
}

#pragma mark Other
- (UIImage *)imageFromView: (UIView *)view atFrame:(CGRect)rect{
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
    
    
}


@end
