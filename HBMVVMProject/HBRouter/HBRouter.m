//
//  HBRouter.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/5.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBRouter.h"
#import "HBRouterUtils.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define customErrorDomain @"com.HBRouter.mvvm"

@interface HBRouter() {
   
}
@property(nonatomic,strong) NSMutableDictionary *params;
@end

@implementation HBRouter
- (instancetype)init {
    self = [super init];
    if (self) {
        if (!self.params) {
            self.params = [NSMutableDictionary dictionaryWithCapacity:1.0];
        }
    }
    return self;
}
+ (nullable id)openURL:(nonnull NSString *)urlString arg:(nullable id)arg error:( NSError*__nullable *__nullable)error completion:(nullable HBRouterCompletion)completion {
    NSDictionary *dict = HBURLRouterURL(urlString);
    NSArray *keys = dict.allKeys;
    if (!dict||keys.count < 2||keys.count >= 3) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"domain or method errror!!!"                                                                      forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:customErrorDomain code:0 userInfo:userInfo];
        return nil;
    }
    NSString *className =[dict objectForKey:@(0)];
    NSString *classMethodName =[dict objectForKey:@(1)];
    NSString *aSelectorName = [NSString stringWithFormat:@"routerHandle_%@_%@:callback:",className,classMethodName];
    SEL  sel = NSSelectorFromString(aSelectorName);
    Class  clss = NSClassFromString(className);
    if (clss) {
        id returnValue = ((id (*)(id, SEL, id,HBRouterCompletion))
                          objc_msgSend)(clss,
                                        sel,
                                        arg,
                                        completion);
        return returnValue;
    } else {
        NSString *routerFormate = [NSString stringWithFormat:@"router://%@/%@ is not contain",className,classMethodName];
        NSLog(@"%@",routerFormate);
        return nil;
    }
}
@end
