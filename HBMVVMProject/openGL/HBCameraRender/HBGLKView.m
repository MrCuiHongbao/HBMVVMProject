//
//  HBGLKView.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/12.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLKView.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "NSGLSharder.h"
#import "HBGLTools.h"

@interface HBGLKView() {
    GLuint _displayTextureID;
    BOOL _shouldDeleteTextureID;

    
    CVOpenGLESTextureCacheRef cameraTextureCache;
    CVOpenGLESTextureRef cameraTexture;
    
    PixelBufferType bufferType;
}
@property (nonatomic, strong) EAGLContext *glContext;
@end
@implementation HBGLKView
- (void)dealloc
{
    if ( [EAGLContext currentContext] != self.glContext ) {
        [EAGLContext setCurrentContext:self.glContext];
    }

    if(cameraTextureCache )
    {
        CFRelease(cameraTextureCache);
        cameraTextureCache = NULL;
    }
}
- (instancetype)initWithFrame:(CGRect)frame  withEAGLContext:(EAGLContext *)context withPixelBufferType:(PixelBufferType)type{
    self = [super initWithFrame:frame context:context];
    if (self) {
        self.glContext = context;
        bufferType = type;
        if (bufferType == PixelBufferTypeRGBA) {
            [self loadBGRARenderShader];
        } else if(bufferType == PixelBufferTypeYUV) {
            [self loadYUVARenderShader];
        }
        [self initTextureCache];
    }
    return self;
}
- (void) initTextureCache {
    
    if(cameraTextureCache ) {
        
        CFRelease(cameraTextureCache);
        cameraTextureCache = NULL;
    }
    
    CVOpenGLESTextureCacheCreate(kCFAllocatorDefault,
                                 NULL,
                                  self.glContext,
                                 NULL,
                                 &cameraTextureCache);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    if (_shouldDeleteTextureID) {
        glClearColor(1.0, 0.0, 0.0, 0.0);
        glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT);

        if (bufferType == PixelBufferTypeYUV) {
//                glUseProgram(nv12Program);
//                glUniform1i(uniforms[UNIFORM_Y], 0);
//                glUniform1i(uniforms[UNIFORM_UV], 1);
//                glUniformMatrix3fv(uniforms[UNIFORM_COLOR_CONVERSION_MATRIX], 1, GL_FALSE, preferredConversion);
        } else if (bufferType == PixelBufferTypeRGBA) {
            [[HBGLTools shareTools] draw];
        }
        
        _shouldDeleteTextureID = NO;
    }
}

- (void) getTextureFromBuffer:(CVPixelBufferRef)pixelBuffer {
    if (!pixelBuffer) {
        NSLog(@"pixelBuffer is NULL.");
    }
    if ( [EAGLContext currentContext] != self.glContext ) {
        [EAGLContext setCurrentContext:self.glContext];
    }
    CVReturn error;
    if (CVPixelBufferGetPixelFormatType(pixelBuffer) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange || CVPixelBufferGetPixelFormatType(pixelBuffer) == kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange) {
        bufferType = PixelBufferTypeYUV;
    } else if (CVPixelBufferGetPixelFormatType(pixelBuffer) == kCVPixelFormatType_32BGRA) {
        bufferType = PixelBufferTypeRGBA;
    }else {
        NSLog(@"Not support current format.");
        return;
    }
    int w = (int)CVPixelBufferGetWidth(pixelBuffer);
    int h = (int)CVPixelBufferGetHeight(pixelBuffer);
    CVOpenGLESTextureRef lumaTexture,chromaTexture,renderTexture;
    if (bufferType == PixelBufferTypeYUV) {
        // Y
        glActiveTexture(GL_TEXTURE0);
        
        error = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                             cameraTextureCache,
                                                             pixelBuffer,
                                                             NULL,
                                                             GL_TEXTURE_2D,
                                                             GL_LUMINANCE,
                                                             w,
                                                             h,
                                                             GL_LUMINANCE,
                                                             GL_UNSIGNED_BYTE,
                                                             0,
                                                             &lumaTexture);
        if (error) {
            NSLog(@"Error at CVOpenGLESTextureCacheCreateTextureFromImage %d", error);
        }else {
//            _lumaTexture = lumaTexture;
        }
        
        glBindTexture(CVOpenGLESTextureGetTarget(lumaTexture), CVOpenGLESTextureGetName(lumaTexture));
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        
        // UV
        glActiveTexture(GL_TEXTURE1);
        error = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                             cameraTextureCache,
                                                             pixelBuffer,
                                                             NULL,
                                                             GL_TEXTURE_2D,
                                                             GL_LUMINANCE_ALPHA,
                                                             w / 2,
                                                             h / 2,
                                                             GL_LUMINANCE_ALPHA,
                                                             GL_UNSIGNED_BYTE,
                                                             1,
                                                             &chromaTexture);
        if (error) {
            NSLog(@"Error at CVOpenGLESTextureCacheCreateTextureFromImage %d", error);
        }else {
//            _chromaTexture = chromaTexture;
        }
        glBindTexture(CVOpenGLESTextureGetTarget(chromaTexture), CVOpenGLESTextureGetName(chromaTexture));
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    } else if(bufferType == PixelBufferTypeRGBA) {
            CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                         cameraTextureCache,
                                                         pixelBuffer,
                                                         NULL,
                                                         GL_TEXTURE_2D,
                                                         GL_RGBA,
                                                         w,
                                                         h,
                                                         GL_BGRA,
                                                         GL_UNSIGNED_BYTE,
                                                         0,
                                                         &cameraTexture);
            

            GLuint texId = CVOpenGLESTextureGetName(cameraTexture);
            glBindTexture(CVOpenGLESTextureGetTarget(cameraTexture), texId);
            
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        _displayTextureID = texId;
    }
//    glBindTexture(GL_TEXTURE_2D, texId);
    [self renderWithTexture:_displayTextureID applyingOrientation:0 savingCurrentTexture:NO];
    
    if ( cameraTexture != NULL ) {
        CFRelease(cameraTexture);
        cameraTexture = NULL;
    }

    if (cameraTextureCache) {
        CVOpenGLESTextureCacheFlush(cameraTextureCache, 0);
    }
}
/*
 * 将纹理绘制到屏幕上
 */
- (void)renderWithTexture:(unsigned int)name
      applyingOrientation:(int)orientation
     savingCurrentTexture:(bool)enableSaving {
    if (!self.window) {
        glDeleteTextures(1, &_displayTextureID);
        _shouldDeleteTextureID = NO;
        return;
    }
    //saveImage
//    _displayTextureID = name;
    
    if (!_shouldDeleteTextureID){
        _shouldDeleteTextureID = YES;
        [self display];
    }
}
/*
 * load resize shader
 */
- (void) loadBGRARenderShader{
    GLuint vertexShader = [[HBGLTools shareTools] compileShader:RENDER_VERTEX withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [[HBGLTools shareTools] compileShader:RENDER_FRAGMENT withType:GL_FRAGMENT_SHADER];
    [[HBGLTools shareTools] linkProgram:vertexShader frament:fragmentShader];
}
- (void)loadYUVARenderShader {
    
}
@end
