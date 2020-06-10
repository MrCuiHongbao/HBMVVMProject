//
//  HBGLDrawTools.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/2/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLDrawTools.h"
#import "HBGLToolContext.h"
@interface HBGLDrawTools(){
    GLuint vbo;
    GLuint vao;
}
@end

@implementation HBGLDrawTools
- (instancetype)initWithGLContext:(HBGLToolContext *)context {
    self = [super initWithGLContext:context];
    if (self) {
//        self.modelMatrix = GLKMatrix4Identity;
        [self genVBO];
        [self genVAO];
    }
    return self;
}
- (GLfloat *)cubeData {
    static GLfloat cubeData[] = {
        -0.5,   0.5f,  0.0,   0,  0,  1, 0, 0,
        -0.5f,  -0.5f,  0.0,  0,  0,  1, 0, 1,
        0.5f,   -0.5f,  0.0,  0,  0,  1, 1, 1,
        0.5,    -0.5f, 0.0,   0,  0,  1, 1, 1,
        0.5f,  0.5f,  0.0,    0,  0,  1, 1, 0,
        -0.5f,   0.5f,  0.0,  0,  0,  1, 0, 0,
    };
    return cubeData;
}
- (void)genVBO {
    glGenBuffers(1, &vbo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, 6 * 8 * sizeof(GLfloat), [self cubeData], GL_STATIC_DRAW);
}

- (void)genVAO {
    glGenVertexArraysOES(1, &vao);
    glBindVertexArrayOES(vao);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
//    [self.context bindAttribs:NULL];
    
    glBindVertexArrayOES(0);
}
- (void)draw:(HBGLToolContext *)glContext {
    glBindAttribLocation(glContext.program, 0, "aPos");
    
    [glContext active];
    
    [glContext drawTriangles:[self cubeData] vertexCount:3];
}
@end
