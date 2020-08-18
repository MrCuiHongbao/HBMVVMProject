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
#import "HBCamereViewController.h"
@implementation OpenGLModule

HBROUTER_EXTERN_METHOD(OpenGLModule,OpenGLModuleexportInterface, arg, callback) {
//    OpenGLViewController *moreVC = [[OpenGLViewController alloc] init];
    HBCamereViewController *moreVC = [[HBCamereViewController alloc] init];
    return moreVC;
}

HBROUTER_EXTERN_METHOD(OpenGLModule,OpenGLModuleCameraexportInterface, arg, callback) {
    HBCamereViewController *moreVC = [[HBCamereViewController alloc] init];
    return moreVC;
}
@end
