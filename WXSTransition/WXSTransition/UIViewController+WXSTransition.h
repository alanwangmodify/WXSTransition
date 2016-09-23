
#import <UIKit/UIKit.h>
#import "WXSTransitionManager.h"
#import "WXSTransitionProperty.h"
#import "WXSPercentDrivenInteractiveTransition.h"

typedef void(^WXSTransitionBlock)(WXSTransitionProperty *transition);

@interface UIViewController (WXSTransition) <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>




- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent animationType:(WXSTransitionAnimationType )animationType completion:(void (^)(void))completion;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock;
- (void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion;


@end


