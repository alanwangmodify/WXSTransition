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
//    WXSTransitionAnimationTypeNone,
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



#endif /* WXSTypedefConfig_h */
