//
//  WXSTransitionProperty.m
//  WXSTransition
//
//  Created by 王小树 on 16/7/1.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionProperty.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation WXSTransitionProperty


+(void)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet {
    
    unsigned int count = 0;
    unsigned int targetCount = 0;
    
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    objc_property_t *targetPropertyList = class_copyPropertyList([targetObjcet class], &targetCount);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        for (int j = 0; j < targetCount; j++) {
            objc_property_t targetProperty = targetPropertyList[j];
            const char *cTargetName = property_getName(targetProperty);
            NSString *targetPropertyName = [NSString stringWithCString:cTargetName encoding:NSUTF8StringEncoding];
            if ([propertyName isEqualToString:targetPropertyName]) {
                
                SEL getterSelector = NSSelectorFromString(propertyName);
                id value = nil;
                if ([object respondsToSelector:getterSelector]) {
//                    value = ((id (*)(id,SEL))objc_msgSend)(object,getterSelector);
                    value = [object performSelector:getterSelector];
                    
                }
                
                NSString *setterSelectorStr = [NSString stringWithFormat:@"set%@",propertyName.capitalizedString];
                SEL setterSelector = NSSelectorFromString(setterSelectorStr);

                [targetObjcet performSelector:setterSelector withObject:value];
//                ((void (*)(id,SEL,id))objc_msgSend)(targetObjcet,setterSelector,@1);
                
            }
            
        }
    }
    
    free(propertyList);
    free(targetPropertyList);

}
@end
