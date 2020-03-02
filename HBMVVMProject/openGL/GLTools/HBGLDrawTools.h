//
//  HBGLDrawTools.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/2/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBGLObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBGLDrawTools : HBGLObject

- (instancetype)initWithGLContext:(HBGLToolContext *)context;
//- (void)update:(NSTimeInterval)timeSinceLastUpdate;
- (void)draw:(HBGLToolContext *)glContext;
@end

NS_ASSUME_NONNULL_END
