//
//  MoneyModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "MoneyModule.h"
#import "MoneyViewController.h"
#import "HBRouter.h"

@implementation MoneyModule
HBROUTER_EXTERN_METHOD(MoneyModule,MoneyModuleexportInterface, arg, callback) {
    MoneyViewController *moreVC = [[MoneyViewController alloc] init];
    return moreVC;
}
@end
