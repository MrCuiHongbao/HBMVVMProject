//
//  HBNSLog.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/4/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OPEN_LOG

#ifdef  OPEN_LOG
//__LINE__ 代表行数,  __PRETTY_FUNCTION__ 代表当前的函数名
#define DLOG(fmt, ...)      NSLog((@"[Line %d] %s\n" fmt), __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else

#define DLOG(fmt, ...)

#endif
NS_ASSUME_NONNULL_BEGIN

@interface HBNSLog : NSObject

@end

NS_ASSUME_NONNULL_END
