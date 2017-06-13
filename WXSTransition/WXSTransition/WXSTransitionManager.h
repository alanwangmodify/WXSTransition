

#import <UIKit/UIKit.h>
#import "WXSTypedefConfig.h"
@interface WXSTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) NSTimeInterval                    animationTime;
@property (nonatomic, assign) WXSTransitionType                 transitionType;
@property (nonatomic, assign) WXSTransitionAnimationType        animationType;
@property (nonatomic, assign) WXSTransitionAnimationType        backAnimationType;
@property (nonatomic, assign) WXSGestureType                    backGestureType;

@property (nonatomic, weak) UIView                              *startView;
@property (nonatomic, weak) UIView                              *targetView;

@property (nonatomic, assign) BOOL                              isSysBackAnimation;
@property (nonatomic, assign) BOOL                              autoShowAndHideNavBar;
@property (nonatomic, assign) BOOL                              backGestureEnable;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);
@property (nonatomic, copy) void(^completionBlock)();


+(WXSTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;

- (UIImage *)imageFromView: (UIView *)view atFrame:(CGRect)rect;


@end
