//
//  WXSTransitionManager+TypeTool.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/20.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+TypeTool.h"

@implementation WXSTransitionManager (TypeTool)


-(void)backAnimationTypeFromAnimationType:(WXSTransitionAnimationType)type{
    
    switch (type) {
        case WXSTransitionAnimationTypeSysFade:{
            self.backAnimationType = WXSTransitionAnimationTypeSysFade;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPushFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPushFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPushFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPushFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysMoveInFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysMoveInFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysMoveInFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysMoveInFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysRevealFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysRevealFromRight;
            
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysRevealFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysRevealFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCubeFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCubeFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCubeFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCubeFromTop;
            
        }
            break;
        case WXSTransitionAnimationTypeSysSuckEffect:{
            self.backAnimationType = WXSTransitionAnimationTypeSysSuckEffect;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysOglFlipFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysOglFlipFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysOglFlipFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysOglFlipFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysRippleEffect:{
            self.backAnimationType = WXSTransitionAnimationTypeSysRippleEffect;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageUnCurlFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageUnCurlFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageUnCurlFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageUnCurlFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromRight:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageCurlFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromLeft:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageCurlFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromTop:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageCurlFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromBottom:{
            self.backAnimationType = WXSTransitionAnimationTypeSysPageCurlFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysCameraIrisHollowOpen:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCameraIrisHollowClose;
        }
            break;
        case WXSTransitionAnimationTypeSysCameraIrisHollowClose:{
            self.backAnimationType = WXSTransitionAnimationTypeSysCameraIrisHollowOpen;
            
        }
            break;
        default:
            break;
    }
}

-(CATransition *)getSysTransitionWithType:(WXSTransitionAnimationType )type{
    
    CATransition *tranAnimation=[CATransition animation];
    tranAnimation.duration= self.animationTime;
    tranAnimation.delegate = self;
    switch (type) {
        case WXSTransitionAnimationTypeSysFade:{
            tranAnimation.type=kCATransitionFade;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromRight:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromLeft:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromTop:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysPushFromBottom:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromBottom;
            
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromRight:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromLeft:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromTop:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysRevealFromBottom:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromRight:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromLeft:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromTop:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysMoveInFromBottom:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromRight:{
            tranAnimation.type = @"cube";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromLeft:{
            tranAnimation.type = @"cube";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromTop:{
            tranAnimation.type=@"cube";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysCubeFromBottom:{
            tranAnimation.type=@"cube";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysSuckEffect:{
            tranAnimation.type=@"suckEffect";
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromRight:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromLeft:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromTop:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysOglFlipFromBottom:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysRippleEffect:{
            tranAnimation.type=@"rippleEffect";
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromRight:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromLeft:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromTop:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysPageCurlFromBottom:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromRight:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromLeft:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromTop:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case WXSTransitionAnimationTypeSysPageUnCurlFromBottom:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case WXSTransitionAnimationTypeSysCameraIrisHollowOpen:{
            tranAnimation.type=@"cameraIrisHollowOpen";
        }
            break;
        case WXSTransitionAnimationTypeSysCameraIrisHollowClose:{
            tranAnimation.type=@"cameraIrisHollowClose";
        }
            break;
        default:
            break;
    }
    return tranAnimation;
}
@end
