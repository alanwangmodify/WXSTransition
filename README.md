# WXSTransition

###介绍
transition animation asset 
一个界面转场动画集。



在平时开发中，有时候需要一些转场动画给界面调整增添一些活力，而实现这些动画相对比较繁琐。
为了让实现转场更简单，我写了这个界面转场动画集。
调整界面时，只要一行代码就可以实现这里面的动画。
包括系统提供的动画在内，目前有大概50种动画。

###使用方法
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

#####3、支持属性修改

```
[self wxs_presentViewController:<#(UIViewController *)#> makeTransition:^(WXSTransitionManager *transition) {
transition.animationType =  WXSTransitionAnimationTypePointSpreadPresent;
transition.animationTime = 1;
}];
```
可以通过transition设置动画时间、类型等属性，目前可修改属性不多，以后版本会增加

#####4、特殊调用

像point Spread 、ViewMoveToNextVC这样的动画，需要个起始view，只要将目标控制器的startView指向这个view就可以了，代码如下；

![view_move_next.gif](http://upload-images.jianshu.io/upload_images/1819750-f1844a487d21b5ae.gif?imageMogr2/auto-orient/strip)

```
DetailViewController *vc = [[DetailViewController alloc] init];
CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
vc.startView = cell.imgView;
[self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionManager *transition) {
transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
transition.animationTime = 1;
}];

```

###动画效果图

#####自定义动画

boom:
![boom.gif](http://upload-images.jianshu.io/upload_images/1819750-002a3e7ba717a4a2.gif?imageMogr2/auto-orient/strip)

brick:
![brick_close_H.gif](http://upload-images.jianshu.io/upload_images/1819750-1233dff7dcc1f781.gif?imageMogr2/auto-orient/strip)
![brick_open_V.gif](http://upload-images.jianshu.io/upload_images/1819750-ac6f189e6ab77103.gif?imageMogr2/auto-orient/strip)

cove:
![cover.gif](http://upload-images.jianshu.io/upload_images/1819750-b0d659fc4ac51cce.gif?imageMogr2/auto-orient/strip)

spread:
![point_spread.gif](http://upload-images.jianshu.io/upload_images/1819750-9ae58fa6a6a944e8.gif?imageMogr2/auto-orient/strip)
![spread_from_right.gif](http://upload-images.jianshu.io/upload_images/1819750-0b3716c415b1440d.gif?imageMogr2/auto-orient/strip)
![spread_from_top.gif](http://upload-images.jianshu.io/upload_images/1819750-3886af1868ca5484.gif?imageMogr2/auto-orient/strip)

view move:
![view_move_next.gif](http://upload-images.jianshu.io/upload_images/1819750-f1844a487d21b5ae.gif?imageMogr2/auto-orient/strip)

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

###后语

现在是第一个版本，原本准备支持交互手势，但是一些动画使用了交互手势存在许多问题，所以这个版本去除了，准备在以后的版本中增加一些以下功能：
1、添加一些酷炫的转场动画
2、支持交互手势
3、提供自定义动画接口，让使用者想实现自己的转场动画时，不用实现各种代理等繁琐工作，专注于fromVC,和toVC的动画逻辑。