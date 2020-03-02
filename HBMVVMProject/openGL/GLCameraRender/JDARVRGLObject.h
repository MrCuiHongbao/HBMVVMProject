//
//  JDARVRGLObject.h
//  OpenGLESLearn
//
//  Created by wang yang on 2017/5/16.
//  Copyright © 2017年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/glext.h>
#import "JDARVRGLContext.h"

@interface JDARVRGLObject : NSObject
@property (strong, nonatomic) JDARVRGLContext *context;
@property (assign, nonatomic) GLKMatrix4 modelMatrix;

- (id)initWithGLContext:(JDARVRGLContext *)context;
- (void)update:(NSTimeInterval)timeSinceLastUpdate;
- (void)draw:(JDARVRGLContext *)glContext;
@end
