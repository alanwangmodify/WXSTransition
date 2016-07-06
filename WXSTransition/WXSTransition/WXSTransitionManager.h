

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"
@interface WXSTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>


@property (nonatomic,assign) NSTimeInterval animationTime;

@property (nonatomic,assign) WXSTransitionType transitionType;

@property (nonatomic,assign) WXSTransitionAnimationType animationType;

@property (nonatomic,assign) WXSGestureType backGestureType;

@property (nonatomic,assign) BOOL isSysBackAnimation;

@property (nonatomic,assign) BOOL backGestureEnable;


@end
