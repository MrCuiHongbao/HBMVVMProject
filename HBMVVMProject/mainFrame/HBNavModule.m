//
//  HBNavModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBNavModule.h"
#import "HBNavigationController.h"
#import "HBRouter.h"
@implementation HBNavModule
HBROUTER_EXTERN_METHOD(HBNavModule,HBNavModuleexportInterface, arg, callback) {
    UIViewController *rootVC = [arg objectForKey:@"rootVC"];
    if (!rootVC) {
        return nil;
    }
    HBNavigationController *vc = [[HBNavigationController alloc] initWithRootViewController:rootVC];
    return vc;
}
@end
