//
//  WXSPercentDrivenInteractiveTransition.h
//  WXSTransition
//
//  Created by 王小树 on 16/6/1.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"

typedef void(^ActionBlock)(void);

//继承自 实现了UIViewControllerInteractiveTransitioning协议的UIPercentDrivenInteractiveTransition
@interface WXSPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) WXSGestureType getstureType;
@property (readonly, assign, nonatomic) BOOL isInteractive;
@property (nonatomic, assign) WXSTransitionType transitionType;

@property (nonatomic, copy) ActionBlock presentBlock;
@property (nonatomic, copy) ActionBlock pushBlock;
@property (nonatomic, copy) ActionBlock dismissBlock;
@property (nonatomic, copy) ActionBlock popBlock;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);

-(void)addGestureToViewController:(UIViewController *)vc;

@end
