//
//  OpenGLModule.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "OpenGLModule.h"
#import "OpenGLViewController.h"
#import "HBRouter.h"
@implementation OpenGLModule

HBROUTER_EXTERN_METHOD(OpenGLModule,OpenGLModuleexportInterface, arg, callback) {
    OpenGLViewController *moreVC = [[OpenGLViewController alloc] init];
    return moreVC;
}
@end
