# WXSTransition

###介绍
transition animation asset 
一个界面转场动画集。
在平时开发中，有时候需要一些转场动画给界面调整增添一些活力，而实现这些动画相对比较繁琐。
为了让我写了这个界面转场动画集。
调整界面时，只要一行代码就可以

###使用方法
#####1、首先导入头文件
```#import "UINavigationController+WXSTransition.h"```

#####2、一行代码就可以调用
Push:
```
 [self.navigationController wxs_pushViewController:<#(UIViewController *)#> animationType:<#(WXSTransitionAnimationType)#>];
```
Present:

```
[self wxs_presentViewController:<#(UIViewController *)#> animationType:<#(WXSTransitionAnimationType)#> completion:<#^(void)completion#>]
```

```(WXSTransitionAnimationType)```是转场动画类型，通过这个枚举选择你想要的转场动画。

#####3、支持属性修改

```
[self wxs_presentViewController:<#(UIViewController *)#> makeTransition:^(WXSTransitionManager *transition) {
transition.animationType =  WXSTransitionAnimationTypePointSpreadPresent;
transition.animationTime = 1;
}];
```
可以通过transition设置动画时间、类型等属性，目前可修改属性不多，以后版本会增加

#####4、特殊调用

像point Spread 、ViewMoveToNextVC这样的动画，需要个起始view，只要将目标控制器的startView指向这个view就可以了，代码如下；

```
DetailViewController *vc = [[DetailViewController alloc] init];
CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
vc.startView = cell.imgView;
[self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionManager *transition) {
transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
transition.animationTime = 1;
}];

```
![view_move_next.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/view_move_next.gif)
###动画效果图

#####自定义动画
![boom.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/boom.gif)
![brick_close_H.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/brick_close_H.gif)
![brick_open_V.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/brick_open_V.gif)
![cover.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/cover.gif)
![point_spread.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/point_spread.gif)
![spread_from_right.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/spread_from_right.gif)
![spread_from_top.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/spread_from_top.gif)
![view_move_next.gif](https://github.com/alanwangmodify/WXSTransition/blob/master/gif/view_move_next.gif)


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
