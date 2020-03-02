//
//  Plane.h
//  OpenGLESLearn
//
//  Created by wang yang on 2017/6/15.
//  Copyright © 2017年 wangyang. All rights reserved.
//

#import "JDARVRGLObject.h"

@interface JDARVRVideoPlane : JDARVRGLObject
@property (assign, nonatomic) GLuint yuv_yTexture;
@property (assign, nonatomic) GLuint yuv_uvTexture;
- (instancetype)initWithGLContext:(JDARVRGLContext *)context;
- (void)update:(NSTimeInterval)timeSinceLastUpdate;
- (void)draw:(JDARVRGLContext *)glContext;
@end
