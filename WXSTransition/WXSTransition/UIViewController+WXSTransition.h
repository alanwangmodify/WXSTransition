
#import <UIKit/UIKit.h>
#import "WXSTransitionManager.h"
#import "WXSTransitionProperty.h"
#import "WXSPercentDrivenInteractiveTransition.h"

typedef void(^WXSTransitionBlock)(WXSTransitionProperty *transition);

@interface UIViewController (WXSTransition) <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) WXSTransitionAnimationType    wxs_animationType;
@property (nonatomic, strong) UIView                        *wxs_targetView;
@property (nonatomic, strong) UIView                        *wxs_startView;
@property (nonatomic, copy  ) WXSTransitionBlock            wxs_callBackTransition;
@property (nonatomic, assign) BOOL                          wxs_delegateFlag;
@property (nonatomic, assign) BOOL                          wxs_addTransitionFlag;

@property (nonatomic, weak  ) id                            wxs_transitioningDelegate;
@property (nonatomic, weak  ) id                            wxs_tempNavDelegate;


- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent animationType:(WXSTransitionAnimationType )animationType completion:(void (^)(void))completion;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion;


@end


