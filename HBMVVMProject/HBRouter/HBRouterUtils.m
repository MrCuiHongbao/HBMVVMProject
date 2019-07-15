//
//  HBRouterUtils.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/8.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBRouterUtils.h"
@implementation NSString (HBURLEncode)
- (NSString *)URLEncode {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]%"] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)URLDecode {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self,CFSTR(""));
}
@end

@implementation HBRouterUtils
NSString *HBURLRouteDecodeURLQueryParamters(NSDictionary *paramters) {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:paramters];
    NSArray *allKeys = params.allKeys;
    NSMutableString *path = [[NSMutableString alloc] init];
    for (int i=0; i<allKeys.count; i++) {
        if (i > 0) {
            [path appendString:@"&"];
        }
        NSString *key = [NSString stringWithFormat:@"%@",allKeys[i]];
        NSString *value = [NSString stringWithFormat:@"%@",params[key]];
        //  对拼接的参数进行编码
        NSString *segment = [NSString stringWithFormat:@"%@=%@",[key URLEncode], [value URLEncode]];
        [path appendString:segment];
    }
    return path;
}
NSDictionary *HBURLRouterURL(NSString *routerString) {
    NSURL *url = [NSURL URLWithString:routerString];
    if ([url.scheme isEqualToString:@"router://"]) {
        NSLog(@"schema is error!! you must start with router://");
    }
    NSString * scheme = url.scheme;
    NSInteger  schemeLength = scheme.length+3;//://长度为3
    
    NSInteger   routerStringLength =routerString.length-schemeLength;
    
    NSString *resourceSpecifier = [routerString substringWithRange:NSMakeRange(schemeLength, routerStringLength)];
    NSArray *cms = [resourceSpecifier componentsSeparatedByString:@"/"];
    NSMutableDictionary *classInfo = [NSMutableDictionary dictionaryWithCapacity:1.0];
    [cms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [classInfo setObject:obj forKey:@(idx)];
    }];
    return classInfo;
}

@end
