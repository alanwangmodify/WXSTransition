
#import <UIKit/UIKit.h>
#import "WXSTransitionManager.h"
#import "WXSTransitionProperty.h"
#import "WXSPercentDrivenInteractiveTransition.h"

typedef void(^WXSTransitionBlock)(WXSTransitionProperty *transition);

@interface UIViewController (WXSTransition) <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) WXSTransitionAnimationType animationType;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIView *startView;
@property (nonatomic, copy) WXSTransitionBlock callBackTransition;
@property (nonatomic, assign) BOOL wxs_DelegateFlag;

- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent animationType:(WXSTransitionAnimationType )animationType completion:(void (^)(void))completion;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion;



@end


