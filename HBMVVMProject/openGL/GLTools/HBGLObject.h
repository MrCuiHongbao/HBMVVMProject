//
//  HBGLObject.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/2/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBGLToolContext.h"
NS_ASSUME_NONNULL_BEGIN

@interface HBGLObject : NSObject
@property (strong, nonatomic) HBGLToolContext *context;
//@property (assign, nonatomic) GLKMatrix4 modelMatrix;

- (id)initWithGLContext:(HBGLToolContext *)context;
- (void)update:(NSTimeInterval)timeSinceLastUpdate;
- (void)draw:(HBGLToolContext *)glContext;
@end

NS_ASSUME_NONNULL_END
