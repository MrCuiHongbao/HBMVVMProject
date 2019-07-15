//
//  HBRouterUtils.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/8.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (HBURLEncode)
- (NSString *)URLEncode;
- (NSString *)URLDecode;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HBRouterUtils : NSObject

FOUNDATION_EXTERN NSString *HBURLRouteDecodeURLQueryParamters(NSDictionary *paramters);

FOUNDATION_EXTERN NSDictionary *HBURLRouterURL(NSString *urlStr);
@end

NS_ASSUME_NONNULL_END
