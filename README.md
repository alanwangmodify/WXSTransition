# WXSTransition

###介绍(Introduce)
It is a transition animation asset。
We can add some transiton animations between view controllers in our iOS Apps .
Now,it is easily  to do this by this animation asset,even only one line of code.
It includes about 50 kinds of animations.
Now, it support 4 kinds of gesture for pop view controller. You can see the property  in ```WXSTransitionProperty```



这一个界面转场动画集。
目前只支持纯代码。
在平时开发中，有时候需要一些转场动画给界面调整增添一些活力，而实现这些动画相对比较繁琐。为了让实现转场更简单，我写了这个界面转场动画集。跳转界面时，只要一行代码就可以实现这里面的动画。包括系统提供的动画在内，目前有大概50种动画。

现在已支持手势返回，有四个手势可以选择，可以在```WXSTransitionProperty```查看相关相关属性

###使用方法(Usage)
#####1、首先导入头文件
```#import "UINavigationController+WXSTransition.h"```

#####2、一行代码就可以调用
Push:
```
 [self.navigationController wxs_pushViewController:(UIViewController *) animationType:(WXSTransitionAnimationType)];
```
Present:

```
[self wxs_presentViewController:(UIViewController *) animationType:(WXSTransitionAnimationType) completion:^{

}];
```
说明：
WXSTransitionAnimationType是转场动画类型，通过这个枚举选择你想要的转场动画。

#####3、支持属性修改（Custom made property）

```
[self wxs_presentViewController:<#(UIViewController *)#> makeTransition:^(WXSTransitionManager *transition) {
transition.animationType =  WXSTransitionAnimationTypePointSpreadPresent;
transition.animationTime = 1;
}];
```
可以通过transition设置动画时间、、返回手势、动画类型等属性，可以在```WXSTransitionProperty```查看相关可修改属性。


像point Spread 、ViewMoveToNextVC这样的动画，需要个起始view，只要将目标控制器的startView指向这个view就可以了，代码如下；
![view_move_next.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/view_move_next.gif)

```
[self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
transition.animationTime = 1;
transition.startView  = cell.imgView;
transition.targetView = vc.imageView;
}];

```

###动画效果图

#####自定义动画

boom:
![boom.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/boom.gif)

brick:
![brick_close_H.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/brick_close_H.gif)
![brick_open_V.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/brick_open_V.gif)

cover:
![cover.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/cover.gif)

spread:
![point_spread.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/point_spread.gif)
![spread_from_right.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/spread_from_right.gif)
![spread_from_top.gif](http://upload-images.jianshu.io/upload_images/1819750-3886af1868ca5484.gif?imageMogr2/auto-orient/strip)

view move:
![view_move_next.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/view_move_next.gif)

frgmentFromRight:
![frgmentFromRight.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/frgmentFromRight.gif)

fragmentFromTop:
![fragmentFromTop.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/fragmentFromTop.gif)

normalViewMove:
![normalViewMove.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/normalViewMove.gif)

insideThenPush:
![insideThenPush.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/insideThenPush.gif)

gestureSpread:
![gestureSpread.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/gestureSpread.gif)

######系统动画
iOS自身其实有许多不错的转场动画，在这个转场动画集里也进行了封装，使用方法跟自定义转场动画一样。

Push:
```
[self.navigationController wxs_pushViewController:<#(UIViewController *)#> animationType:<#(WXSTransitionAnimationType)#>];
```
Present:

```
[self wxs_presentViewController:<#(UIViewController *)#> animationType:<#(WXSTransitionAnimationType)#> completion:<#^(void)completion#>]
```

![sys_oglFlip.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/sys_oglFlip.gif)
![sys_pageCurl.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/sys_pageCurl.gif)


喜欢在大家平时的开发中能有所帮助，喜欢的同学劳烦加个Star


