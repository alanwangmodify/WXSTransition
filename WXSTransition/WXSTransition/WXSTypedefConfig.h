//
//  WXSTypedefConfig.h
//  WXSTransition
//
//  Created by 王小树 on 16/6/3.
//  Copyright © 2016年 王小树. All rights reserved.
//

#ifndef WXSTypedefConfig_h
#define WXSTypedefConfig_h


// ************** Enum **************
typedef NS_ENUM(NSInteger,WXSTransitionAnimationType){
    WXSTransitionAnimationTypeSysFade = 1,                   //淡入淡出
    WXSTransitionAnimationTypeSysPush,                       //推挤
    WXSTransitionAnimationTypeSysReveal,                     //揭开
    WXSTransitionAnimationTypeSysMoveIn,                     //覆盖
    WXSTransitionAnimationTypeSysCube,                       //立方体
    WXSTransitionAnimationTypeSysSuckEffect,                 //吮吸
    WXSTransitionAnimationTypeSysOglFlip,                    //翻转
    WXSTransitionAnimationTypeSysRippleEffect,               //波纹
    WXSTransitionAnimationTypeSysPageCurl,                   //翻页
    WXSTransitionAnimationTypeSysPageUnCurl,                 //反翻页
    WXSTransitionAnimationTypeSysCameraIrisHollowOpen,       //开镜头
    WXSTransitionAnimationTypeSysCameraIrisHollowClose,      //关镜头
    WXSTransitionAnimationTypeSysCurlDown,                   //下翻页
    WXSTransitionAnimationTypeSysCurlUp,                     //上翻页
    WXSTransitionAnimationTypeSysFlipFromLeft,               //左翻转
    WXSTransitionAnimationTypeSysFlipFromRight,              //右翻转
    
    
    WXSTransitionAnimationTypeDefault,
    WXSTransitionAnimationTypePageTransition,
    WXSTransitionAnimationTypePageTransition2,
    WXSTransitionAnimationTypeViewMoveToNextVC,
    WXSTransitionAnimationTypeCover,
    WXSTransitionAnimationTypeSpreadPresent,
    WXSTransitionAnimationTypeBoom,
    WXSTransitionAnimationTypeBrick,
};

typedef NS_ENUM(NSInteger,WXSTransitionType){
    WXSTransitionTypePop,
    WXSTransitionTypePush,
    WXSTransitionTypePresent,
    WXSTransitionTypeDismiss,
};


typedef NS_ENUM(NSInteger,WXSGestureType){
    
    WXSGestureTypeNone,
    WXSGestureTypePanLeft,
    WXSGestureTypePanRight,
    WXSGestureTypePanUp,
    WXSGestureTypePanDown,
    WXSGestureTypeTap,
    
};
//系统动画类型
typedef NS_ENUM(NSInteger,WXSTransitionSysAnimationType){
    
    WXSTransitionSysAnimationTypeFade = 1,                   //淡入淡出
    WXSTransitionSysAnimationTypePush,                       //推挤
    WXSTransitionSysAnimationTypeReveal,                     //揭开
    WXSTransitionSysAnimationTypeMoveIn,                     //覆盖
    WXSTransitionSysAnimationTypeCube,                       //立方体
    WXSTransitionSysAnimationTypeSuckEffect,                 //吮吸
    WXSTransitionSysAnimationTypeOglFlip,                    //翻转
    WXSTransitionSysAnimationTypeRippleEffect,               //波纹
    WXSTransitionSysAnimationTypePageCurl,                   //翻页
    WXSTransitionSysAnimationTypePageUnCurl,                 //反翻页
    WXSTransitionSysAnimationTypeCameraIrisHollowOpen,       //开镜头
    WXSTransitionSysAnimationTypeCameraIrisHollowClose,      //关镜头
    WXSTransitionSysAnimationTypeCurlDown,                   //下翻页
    WXSTransitionSysAnimationTypeCurlUp,                     //上翻页
    WXSTransitionSysAnimationTypeFlipFromLeft,               //左翻转
    WXSTransitionSysAnimationTypeFlipFromRight, //右翻转
    
    
};






#endif /* WXSTypedefConfig_h */
