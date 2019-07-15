//
//  DiscoveryModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "DiscoveryModule.h"
#import "DiscoveryViewController.h"
#import "HBRouter.h"

@implementation DiscoveryModule
HBROUTER_EXTERN_METHOD(DiscoveryModule,DiscoveryModuleexportInterface, arg, callback) {
    DiscoveryViewController *mineVC = [[DiscoveryViewController alloc] init];
    return mineVC;
}
@end
