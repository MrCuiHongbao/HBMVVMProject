//
//  TDPGLGeometry.m
//  OpenGLESLearn
//
//  Created by wangyang on 2017/6/6.
//  Copyright © 2017年 wangyang. All rights reserved.
//

#import "JDARVRGLGeometry.h"

@interface JDARVRGLGeometry () {
    GLuint vbo;
    BOOL vboValid;
}
@property (strong, nonatomic) NSMutableData *vertexData;
@end

@implementation JDARVRGLGeometry

- (instancetype)initWithGeometryType:(ARVRGLGeometryType)geometryType
{
    self = [super init];
    if (self) {
        self.geometryType = geometryType;
        vboValid = NO;
        self.vertexData = [NSMutableData data];
    }
    return self;
}

- (void)dealloc {
    if (vboValid) {
        glDeleteBuffers(1, &vbo);
    }
}

- (void)appendVertex:(ARVRGLVertex)vertex {
    void * pVertex = (void *)(&vertex);
    NSUInteger size = sizeof(ARVRGLVertex);
    [self.vertexData appendBytes:pVertex length:size];
}

- (GLuint)getVBO {
    if (vboValid == NO) {
        glGenBuffers(1, &vbo);
        vboValid = YES;
        glBindBuffer(GL_ARRAY_BUFFER, vbo);
        glBufferData(GL_ARRAY_BUFFER, [self.vertexData length], self.vertexData.bytes, GL_STATIC_DRAW);
    }
    return vbo;
}

- (int)vertexCount {
    return [self.vertexData length] / sizeof(ARVRGLVertex);
}
@end
