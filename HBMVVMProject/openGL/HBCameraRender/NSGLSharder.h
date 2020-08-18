//
//  NSGLSharder.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CHB_STRINGIZE(x) #x
#define CHB_STRINGIZE2(x)     CHB_STRINGIZE(x)
#define CHB_SHADER_STRING(text) @ CHB_STRINGIZE2(text)

extern NSString *RENDER_VERTEX;

extern NSString *RENDER_FRAGMENT;

NS_ASSUME_NONNULL_BEGIN

@interface NSGLSharder : NSObject

@end

NS_ASSUME_NONNULL_END
