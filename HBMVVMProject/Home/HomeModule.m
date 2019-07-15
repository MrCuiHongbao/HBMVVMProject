//
//  HomeModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HomeModule.h"
#import "HBRouter.h"
#import "HomeViewController.h"
@implementation HomeModule
HBROUTER_EXTERN_METHOD(HomeModule,HomeModuleexportInterface, arg, callback) {
    HomeViewController *mineVC = [[HomeViewController alloc] init];
    return mineVC;
}
@end
