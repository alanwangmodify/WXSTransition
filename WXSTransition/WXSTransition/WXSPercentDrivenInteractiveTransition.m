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


@end

@implementation WXSPercentDrivenInteractiveTransition


-(void)addGestureToViewController:(UIViewController *)vc{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    self.vc = vc;
    [vc.view addGestureRecognizer:pan];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    
    CGFloat percent = 0.0;
    CGFloat totalWidth = pan.view.bounds.size.width;
    CGFloat totalHeight = pan.view.bounds.size.height;
    switch (self.getstureType) {
            
        case WXSGestureTypePanLeft:{
            CGFloat x = [pan translationInView:pan.view].x;
            percent = -x/totalWidth;
        }
            break;
        case WXSGestureTypePanRight:{
            CGFloat x = [pan translationInView:pan.view].x;
            percent = x/totalWidth;
        }
            break;
        case WXSGestureTypePanDown:{
            
            CGFloat y = [pan translationInView:pan.view].y;
            percent = y/totalHeight;
            
        }
            break;
        case WXSGestureTypePanUp:{
            CGFloat y = [pan translationInView:pan.view].y;
            percent = -y/totalHeight;
        }
            
        default:
            break;
    }

    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            _isInter = YES;
//            if (percent>0.01) {
//                [self beganGesture];
//            }
            [self beganGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            _isInter = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
    
#ifdef DEBUG
    NSLog(@"%lf",percent);
#endif
    
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

-(BOOL)isInteractive {
    return _isInter;
}

@end
