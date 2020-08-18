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
#import <objc/runtime.h>

@implementation MineModule
HBROUTER_EXTERN_METHOD(MineModule,MineModuleexportInterface, arg, callback) {
    MineViewController *mineVC = [[MineViewController alloc] init];
    [MineModule getMineClassAllMethods];
   NSDictionary *dict = [MineModule getMineAllPropertiesAndVaules:mineVC];
    NSLog(@"dict===============>%@",dict);
    return mineVC;
}
+(NSArray *)getMineClassAllMethods
{
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList([MineViewController class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i=0;i<methodCount;i++)
    {
        Method temp = methodList[i];
        IMP imp = method_getImplementation(temp);
        NSLog(@"IMP--------->%p",imp);
        SEL name_f = method_getName(temp);
        NSLog(@"SEL--------->%@",NSStringFromSelector(name_f));
        const char* name_s =sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding =method_getTypeEncoding(temp);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    return methodsArray;
}
/* 获取对象的所有属性和属性内容 */
+ (NSDictionary *)getMineAllPropertiesAndVaules:(NSObject *)obj
{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties =class_copyPropertyList([obj class], &outCount);
    for ( int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [propsDic setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return propsDic;
}
@end
