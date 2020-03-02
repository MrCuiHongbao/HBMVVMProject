//
//  JDARVRCameraRender.h
//  JDBLocalizationModule-localizationModuleResource
//
//  Created by hongbao.cui on 2019/4/18.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "JDARVRVideoPlane.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDARVRCameraRender : NSObject
@property (strong, nonatomic) JDARVRVideoPlane *videoPlane;
@property (strong, nonatomic) JDARVRGLContext *videoPlaneContext;
@property (assign, nonatomic) GLuint yTexture;
@property (assign, nonatomic) GLuint uvTexture;
@property (assign, nonatomic) GLKMatrix4 videoPlaneProjectionMatrix; // 用于显示视频的ortho投影矩阵
- (void)setupVideoPlane;
//更新相机方向
/*
 angle  M_PI  M_PI_2  ......
 */
- (void)updateCameraOrientation:(CGFloat) angle;

-(void)drawCameraTextAndBindBuffer;
-(void)cameraOutputWithBuffer:(CVPixelBufferRef)sampleBuffer;
@end
NS_ASSUME_NONNULL_END
