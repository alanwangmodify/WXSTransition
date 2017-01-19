//
//  WXSTransitionManager+TypeTool.h
//  WXSTransition
//
//  Created by AlanWang on 16/9/20.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager.h"

@interface WXSTransitionManager (TypeTool)<CAAnimationDelegate>
-(void)backAnimationTypeFromAnimationType:(WXSTransitionAnimationType)type;
-(CATransition *)getSysTransitionWithType:(WXSTransitionAnimationType )type;
@end
