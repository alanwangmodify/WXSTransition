

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"
@interface WXSTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) NSTimeInterval                    animationTime;

@property (nonatomic, assign) WXSTransitionType                 transitionType;

@property (nonatomic, assign) WXSTransitionAnimationType        animationType;
@property (nonatomic, assign) WXSTransitionAnimationType        backAnimationType;

@property (nonatomic, assign) WXSGestureType                    backGestureType;

@property (nonatomic, assign) BOOL                              isSysBackAnimation;

@property (nonatomic, assign) BOOL                              backGestureEnable;

@property (nonatomic, strong) UIView                            *startView;
@property (nonatomic, strong) UIView                            *targetView;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);


+(WXSTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;

@property (nonatomic, copy) void(^completionBlock)();


@end
