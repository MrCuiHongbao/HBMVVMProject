//
//  HBGLToolContext.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/23.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/glext.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBGLToolContext : NSObject

@property (assign, nonatomic) GLuint program;

+ (id)contextWithVertexShaderPath:(NSString *)vertexShaderPath fragmentShaderPath:(NSString *)fragmentShaderPath;

- (id)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader;

- (void)drawTriangles:(GLfloat *)triangleData vertexCount:(GLint)vertexCount;

- (void)active;
@end

NS_ASSUME_NONNULL_END
