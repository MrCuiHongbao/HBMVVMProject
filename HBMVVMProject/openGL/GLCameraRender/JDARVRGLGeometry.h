//
//  TDPGLGeometry.h
//  OpenGLESLearn
//
//  Created by wangyang on 2017/6/6.
//  Copyright © 2017年 wangyang. All rights reserved.
//

#import "JDARVRGLObject.h"

typedef enum : NSUInteger {
    ARVRGLGeometryTypeTriangles,
    ARVRGLGeometryTypeTriangleStrip,
    ARVRGLGeometryTypeTriangleFan,
} ARVRGLGeometryType;

typedef struct {
    GLfloat x;
    GLfloat y;
    GLfloat z;
    GLfloat normalX;
    GLfloat normalY;
    GLfloat normalZ;
    GLfloat u;
    GLfloat v;
} ARVRGLVertex;

static inline ARVRGLVertex GLVertexMake( GLfloat x,
                         GLfloat y,
                         GLfloat z,
                         GLfloat normalX,
                         GLfloat normalY,
                         GLfloat normalZ,
                         GLfloat u,
                         GLfloat v) {
    ARVRGLVertex vertex;
    vertex.x = x;
    vertex.y = y;
    vertex.z = z;
    vertex.normalX = normalX;
    vertex.normalY = normalY;
    vertex.normalZ = normalZ;
    vertex.u = u;
    vertex.v = v;
    return vertex;
}

@interface JDARVRGLGeometry : JDARVRGLObject
@property (assign, nonatomic) ARVRGLGeometryType geometryType;
- (instancetype)initWithGeometryType:(ARVRGLGeometryType)geometryType;
- (void)appendVertex:(ARVRGLVertex)vertex;
- (GLuint)getVBO;
- (int)vertexCount;
@end
