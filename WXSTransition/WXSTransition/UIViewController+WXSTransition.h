
#import <UIKit/UIKit.h>
#import "WXSTransitionManager.h"
#import "WXSPercentDrivenInteractiveTransition.h"

typedef void(^WXSTransitionBlock)(WXSTransitionManager *transition);

@interface UIViewController (WXSTransition) <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) WXSTransitionAnimationType animationType;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIView *starView;
@property (nonatomic, copy) WXSTransitionBlock callBackTransition;
@property (nonatomic, strong) WXSPercentDrivenInteractiveTransition *fromVCInteraciveTransition;
@property (nonatomic, strong) WXSPercentDrivenInteractiveTransition *toVCInteraciveTransition;


-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock;
-(void)wxs_presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(WXSTransitionBlock)transitionBlock completion:(void (^)(void))completion;



@end


