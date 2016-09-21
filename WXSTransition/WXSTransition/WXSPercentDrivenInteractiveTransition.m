//
//  WXSPercentDrivenInteractiveTransition.m
//  WXSTransition
//
//  Created by 王小树 on 16/6/1.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSPercentDrivenInteractiveTransition.h"
@interface WXSPercentDrivenInteractiveTransition ()
{
    BOOL _isInter;
}

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat percent;



@end

@implementation WXSPercentDrivenInteractiveTransition

-(void)addGestureToViewController:(UIViewController *)vc{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    self.vc = vc;
    [vc.view addGestureRecognizer:pan];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    
    _percent = 0.0;
    CGFloat totalWidth = pan.view.bounds.size.width;
    CGFloat totalHeight = pan.view.bounds.size.height;
    switch (self.getstureType) {
            
        case WXSGestureTypePanLeft:{
            CGFloat x = [pan translationInView:pan.view].x;
            _percent = -x/totalWidth;
        }
            break;
        case WXSGestureTypePanRight:{
            CGFloat x = [pan translationInView:pan.view].x;
            _percent = x/totalWidth;
        }
            break;
        case WXSGestureTypePanDown:{
            
            CGFloat y = [pan translationInView:pan.view].y;
            _percent = y/totalHeight;
            
        }
            break;
        case WXSGestureTypePanUp:{
            CGFloat y = [pan translationInView:pan.view].y;
            _percent = -y/totalHeight;
        }
            
        default:
            break;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            _isInter = YES;
            [self beganGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:_percent];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            _isInter = NO;

            [self continueAction];
            
        }
            break;
        default:
            break;
    }
}



-(void)beganGesture{
    
    switch (_transitionType) {
        case WXSTransitionTypePresent:{
            _presentBlock? _presentBlock() : nil;
        }
            break;
        case WXSTransitionTypeDismiss:{
            _dismissBlock ? _dismissBlock() : [_vc dismissViewControllerAnimated:YES completion:^{
            }];
        }
            break;
        case WXSTransitionTypePush: {
            _pushBlock ? _pushBlock() : nil;
        }
            break;
        case WXSTransitionTypePop:{
            _popBlock ? _popBlock() : [_vc.navigationController popViewControllerAnimated:YES];

        }
            break;
        default:
            break;
    }
    
}

- (BOOL)isInteractive {
    return _isInter;
}

- (void)continueAction{
    if (_displayLink) {
        return;
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(UIChange)];
    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)UIChange {
    
    CGFloat timeDistance = 2.0/60;
    if (_percent > 0.35) {
        _percent += timeDistance;
    }else {
        _percent -= timeDistance;
    }
    [self updateInteractiveTransition:_percent];
        
    if (_percent >= 1.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(YES) : nil;
        [self finishInteractiveTransition];
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    if (_percent <= 0.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(NO) : nil;
        
        [_displayLink invalidate];
        _displayLink = nil;
        [self cancelInteractiveTransition];
    }
}


@end
