//
//  HBTabBarModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBTabBarModule.h"
#import "HBRouter.h"
#import "HBTabBarViewController.h"
@implementation HBTabBarModule

HBROUTER_EXTERN_METHOD(HBTabBarModule,HBTabBaexportInterface, arg, callback) {
    HBTabBarViewController *tabVC = [[HBTabBarViewController alloc] initWithViewControllers:arg];
    return tabVC;
}
@end
