//
//  HBCamereViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/12.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBCamereViewController.h"
#import "HBCameraManager.h"
#import "HBGLKView.h"

@interface HBCamereViewController ()<HBVideoCaptureDelegate>
@property (nonatomic, strong) HBCameraManager *capture;
@property (nonatomic, strong) HBGLKView *glView;
@property (nonatomic,strong)EAGLContext *context;
@end

@implementation HBCamereViewController
- (void)dealloc {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createCamera];
}
- (void)_createCamera {
    _capture = [[HBCameraManager alloc] init];
    _capture.isOutputWithYUV = NO;
    _capture.delegate = self;
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
//    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:self.glView.context.sharegroup];
    [EAGLContext setCurrentContext:self.context];
    
    _glView = [[HBGLKView alloc] initWithFrame: [UIScreen mainScreen].bounds withEAGLContext: self.context withPixelBufferType:PixelBufferTypeRGBA];
    [self.view addSubview:_glView];
    
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:self.glView.context.sharegroup];
    [EAGLContext setCurrentContext:self.context];
    
    [_capture startRunning];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [_glView removeFromSuperview];
//    _glView = nil;
//    self.context = nil;
//    [_capture stopRunning];
//    _capture = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - VideoCaptureDelegate
/*
 * 相机帧经过美化处理后再绘制到屏幕上
 */
- (void)videoCapture:(HBCameraManager *)camera didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CFRetain(sampleBuffer);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (EAGLContext.currentContext != self.context) {
            [EAGLContext setCurrentContext:self.context];
        }
        CVPixelBufferRef imageRef = CMSampleBufferGetImageBuffer(sampleBuffer);
        if (imageRef == nil) {
            CFRelease(sampleBuffer);
            return ;
        }
        [self.glView getTextureFromBuffer:imageRef];
        CFRelease(sampleBuffer);
//        [self.glView renderWithTexture:0 applyingOrientation:0 savingCurrentTexture:NO];
    });
}
@end
