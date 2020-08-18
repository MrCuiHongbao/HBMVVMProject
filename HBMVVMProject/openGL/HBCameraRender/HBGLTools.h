//
//  HBGLTools.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBGLTools : NSObject

@property(nonatomic,assign)GLuint renderProgram;
@property(nonatomic,assign)GLuint renderLocation;
@property(nonatomic,assign)GLuint renderTextureCoordinate;
@property(nonatomic,assign)GLuint renderInputImageTexture;

+ (instancetype)shareTools;

-(int) compileShader:(NSString *)shaderString withType:(GLenum)shaderType;

- (void)linkProgram:(GLuint) vertexShader frament:(GLuint) fragmentShader ;

- (void)draw;
@end

NS_ASSUME_NONNULL_END
