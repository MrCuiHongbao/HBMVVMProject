//
//  MoreModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "MoreModule.h"
#import "HBRouter.h"
#import "MoreViewController.h"

@implementation MoreModule
HBROUTER_EXTERN_METHOD(MoreModule,MoreModuleexportInterface, arg, callback) {
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    return moreVC;
}
@end
