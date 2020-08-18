//
//  HBSwizzlingViewController+HBSwizzling.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/17.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBSwizzlingViewController+HBSwizzling.h"

#import <objc/runtime.h>


@implementation HBSwizzlingViewController (HBSwizzling)
+(void)load {
    simple_Swizzle([self class], @selector(sunli), @selector(swizzling_sunli));
}
BOOL simple_Swizzle(Class aClass,SEL originalSel, SEL swizzleSel)
{
     Method originalMethod = class_getInstanceMethod(aClass, originalSel);
     Method swizzleMethod = class_getInstanceMethod(aClass,swizzleSel);
     method_exchangeImplementations(originalMethod, swizzleMethod);
     return YES;
}

@end
