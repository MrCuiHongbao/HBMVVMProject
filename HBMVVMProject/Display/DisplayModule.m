//
//  DisplayModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "DisplayModule.h"
#import "DisplayViewController.h"
#import "HBRouter.h"
@implementation DisplayModule
HBROUTER_EXTERN_METHOD(DisplayModule,DisplayModuleexportInterface, arg, callback) {
    DisplayViewController *mineVC = [[DisplayViewController alloc] init];
    return mineVC;
}
@end
