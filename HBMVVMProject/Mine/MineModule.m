//
//  MineModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "MineModule.h"
#import "MineViewController.h"
#import "HBRouter.h"

@implementation MineModule
HBROUTER_EXTERN_METHOD(MineModule,MineModuleexportInterface, arg, callback) {
    MineViewController *mineVC = [[MineViewController alloc] init];
    return mineVC;
}
@end
