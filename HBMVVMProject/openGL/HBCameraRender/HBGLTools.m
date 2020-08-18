//
//  HBGLTools.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLTools.h"
#import <UIKit/UIKit.h>

static float TEXTURE_FLIPPED[] = {0.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f, 0.0f,};
static float CUBE[] = {-1.0f, -1.0f, 1.0f, -1.0f, -1.0f, 1.0f, 1.0f, 1.0f,};
@interface HBGLTools() {
    GLfloat vertex[8];
}
@property (nonatomic, assign) unsigned int screenWidth;
@property (nonatomic, assign) unsigned int screenHeight;
@end
static HBGLTools *tools = nil;
@implementation HBGLTools
+ (instancetype)shareTools {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[HBGLTools alloc] init];
    });
    return tools;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat scale = [UIScreen mainScreen].scale;
         _screenWidth = [UIScreen mainScreen].bounds.size.width * scale;
         _screenHeight = [UIScreen mainScreen].bounds.size.height * scale;
        
        float ratio[2] = {1.0, 1.0};
        [self calcVertex:_screenWidth height:_screenHeight ratios:ratio];
        
        for (int i = 0; i < 4; i ++){
               vertex[i * 2] = CUBE[i * 2] / ratio[1];
               vertex[i * 2 + 1] = CUBE[i * 2 + 1] / ratio[0];
           }
    }
    return self;
}
-(int) compileShader:(NSString *)shaderString withType:(GLenum)shaderType {
    GLuint shaderHandle = glCreateShader(shaderType);
    const char * shaderStringUTF8 = [shaderString UTF8String];
    
    int shaderStringLength = (int) [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    glCompileShader(shaderHandle);
    GLint success;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &success);
    
    if (success == GL_FALSE){
        NSLog(@"HBGLTools compiler shader error: %s", shaderStringUTF8);
        return 0;
    }
    return shaderHandle;
}
- (void)linkProgram:(GLuint) vertexShader frament:(GLuint) fragmentShader  {
    _renderProgram = glCreateProgram();
    glAttachShader(_renderProgram, vertexShader);
    glAttachShader(_renderProgram, fragmentShader);
    glLinkProgram(_renderProgram);
    
    GLint linkSuccess;
    glGetProgramiv(_renderProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE){
        NSLog(@"HBGLTools link shader error");
    }
    
    glUseProgram(_renderProgram);
    _renderLocation = glGetAttribLocation(_renderProgram, "position");
    _renderTextureCoordinate = glGetAttribLocation(_renderProgram, "inputTextureCoordinate");
    _renderInputImageTexture = glGetUniformLocation(_renderProgram, "inputImageTexture");
    
    if (vertexShader)
        glDeleteShader(vertexShader);
    
    if (fragmentShader)
        glDeleteShader(fragmentShader);
}
- (void)draw {
    glClearColor(1.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);
    glUseProgram(_renderProgram);
    
    glActiveTexture(GL_TEXTURE0);
    glUniform1i(_renderInputImageTexture, 0);
    
    glVertexAttribPointer(_renderLocation, 2, GL_FLOAT, false, 0, vertex);
    glEnableVertexAttribArray(_renderLocation);
    glVertexAttribPointer(_renderTextureCoordinate, 2, GL_FLOAT, false, 0, TEXTURE_FLIPPED);
    glEnableVertexAttribArray(_renderTextureCoordinate);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(_renderLocation);
    glDisableVertexAttribArray(_renderTextureCoordinate);
    glUseProgram(0);
}
- (void) calcVertex:(int)iWidth height:(int)iHeight ratios:(float *)retRatio{
    int outputWidth = iWidth;
    int outputHeight = iHeight;
    
    int imageHeight = 1280;
    int imageWidth = 720;
    
    float ratio1 = (float)outputWidth / imageWidth;
    float ratio2 = (float)outputHeight / imageHeight;
    
    float ratio = MIN(ratio1, ratio2);
    
    int imageNewHeight = round(imageHeight * ratio);
    int imageNewWidth = round(imageWidth * ratio);
    
    float ratioHeight = imageNewHeight / (float)outputHeight;
    float ratioWidth = imageNewWidth / (float)outputWidth;
    
    retRatio[0] = ratioWidth;
    retRatio[1] = ratioHeight;
}
@end
