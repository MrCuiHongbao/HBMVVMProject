//
//  JDARVRCameraRender.m
//  JDBLocalizationModule-localizationModuleResource
//
//  Created by hongbao.cui on 2019/4/18.
//

#import "JDARVRCameraRender.h"
//#import <JDBFoundationModule/JDBFoundationModule-umbrella.h>
@interface JDARVRCameraRender() {
//    CVPixelBufferRef  pixelBuffer;
}
@property (assign, nonatomic) GLKMatrix4 worldProjectionMatrix; // 3D世界投影矩阵
@property (assign, nonatomic) GLKMatrix4 cameraMatrix; // 3D世界观察矩阵
@property (assign, nonatomic) GLKVector3 cameraPos; // 相机的位置
@end
@implementation JDARVRCameraRender
- (void)dealloc {
//    JDLogInfo(@"JDARVRCameraRender----------->dealloc");
    glDeleteTextures(1, &_yTexture);
    glDeleteTextures(1, &_uvTexture);
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setupVideoPlane {
    glGenTextures(1, &_yTexture);
    glBindTexture(GL_TEXTURE_2D, self.yTexture);
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    
    glGenTextures(1, &_uvTexture);
    glBindTexture(GL_TEXTURE_2D, self.uvTexture);
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    
    glBindTexture(GL_TEXTURE_2D, 0);
    
    self.videoPlaneProjectionMatrix = GLKMatrix4MakeOrtho(-0.5, 0.5, 0.5, -0.5, -100, 100);
    NSBundle *moduleBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ThreeDProductModule" ofType:@"bundle"]];
    NSString *vertexShaderPath = [moduleBundle pathForResource:@"TDP_vertex.glsl"
                                                        ofType:nil];
    NSString *fragmentShaderPath = [moduleBundle pathForResource:@"TDP_frag_video.glsl" ofType:nil];
    self.videoPlaneContext = [JDARVRGLContext contextWithVertexShaderPath:vertexShaderPath fragmentShaderPath:fragmentShaderPath];
    self.videoPlane = [[JDARVRVideoPlane alloc] initWithGLContext:self.videoPlaneContext];
    GLKMatrix4 rotationMatrix = GLKMatrix4MakeRotation(M_PI / 2, 0, 0, 1);
    GLKMatrix4 scaleMatrix = GLKMatrix4MakeScale(1, -1, 1);
    self.videoPlane.modelMatrix = GLKMatrix4Multiply(rotationMatrix, scaleMatrix);
}
- (void)updateCameraOrientation:(CGFloat) angle{
    GLKMatrix4 rotationMatrix = GLKMatrix4MakeRotation(angle, 0, 0, 1);
    GLKMatrix4 scaleMatrix = GLKMatrix4MakeScale(1, -1, 1);
    self.videoPlane.modelMatrix = GLKMatrix4Multiply(rotationMatrix, scaleMatrix);
}
-(void)drawCameraTextAndBindBuffer {
    glDepthMask(GL_FALSE);
    [self.videoPlane.context active];
//    [self drawCamera:pixelBuffer];
//    [self.videoPlane.context setUniform1f:@"elapsedTime" value:(GLfloat)self.elapsedTime];
    [self.videoPlane.context setUniformMatrix4fv:@"projectionMatrix" value:self.videoPlaneProjectionMatrix];
    [self.videoPlane.context setUniformMatrix4fv:@"cameraMatrix" value:GLKMatrix4Identity];
    [self.videoPlane draw:self.videoPlane.context];
    glDepthMask(GL_TRUE);
}
-(void)cameraOutputWithBuffer:(CVPixelBufferRef)pixelBuffer {
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    GLsizei imageWidth = (GLsizei)CVPixelBufferGetWidthOfPlane(pixelBuffer, 0);
    GLsizei imageHeight = (GLsizei)CVPixelBufferGetHeightOfPlane(pixelBuffer, 0);
    void * baseAddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, self.yTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, imageWidth, imageHeight, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, baseAddress);
    glBindTexture(GL_TEXTURE_2D, 0);
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 1);
    imageWidth = (GLsizei)CVPixelBufferGetWidthOfPlane(pixelBuffer, 1);
    imageHeight = (GLsizei)CVPixelBufferGetHeightOfPlane(pixelBuffer, 1);
    void *laAddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.uvTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE_ALPHA, imageWidth, imageHeight, 0, GL_LUMINANCE_ALPHA, GL_UNSIGNED_BYTE, laAddress);
    glBindTexture(GL_TEXTURE_2D, 0);
    
    self.videoPlane.yuv_yTexture = self.yTexture;
    self.videoPlane.yuv_uvTexture = self.uvTexture;
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 1);
}
//-(void)cameraOutputWithBuffer:(CVPixelBufferRef)_pixelBuffer {
//    pixelBuffer = _pixelBuffer;
//}
@end
