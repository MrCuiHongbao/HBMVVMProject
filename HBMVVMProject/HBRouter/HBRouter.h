//
//  HBRouter.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/5.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CustomErrorDomain @"com.xiaodao.test"
typedef enum {
    HBRouterUnKonwnDomainFailed = -1000,
    HBRouterErrorDomainFailed,
}HBRouterErrorFailed;
typedef void(^HBRouterCompletion)(id __nullable object);

NS_ASSUME_NONNULL_BEGIN
// 组件对外公开接口, m组件名, i接口名, p(arg)接收参数, c(callback)回调block
#define HBROUTER_EXTERN_METHOD(m,i,p,c) + (id) routerHandle_##m##_##i:(NSDictionary*)arg callback:(HBRouterCompletion)callback

@interface HBRouter : NSObject

+ (nullable id)openURL:(nonnull NSString *)urlString arg:(nullable id)arg error:( NSError*__nullable *__nullable)error completion:(nullable HBRouterCompletion)completion;

@end

NS_ASSUME_NONNULL_END
