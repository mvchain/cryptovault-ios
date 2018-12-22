//
//  TPSwizzlingDefine.h
//  ToPay
//
//  Created by 蒲公英 on 2018/12/17.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#ifndef TPSwizzlingDefine_h
#define TPSwizzlingDefine_h

#import <objc/runtime.h>

static inline void swizzling_exchangeMethod(Class clazz ,SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
    
    BOOL success = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


#endif /* TPSwizzlingDefine_h */
