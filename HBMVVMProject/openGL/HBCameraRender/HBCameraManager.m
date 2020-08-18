//
//  HBCameraManager.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/16.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBCameraManager.h"
#import <AVFoundation/AVFoundation.h>

@interface HBCameraManager()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, readwrite) AVCaptureDevicePosition devicePosition; // default AVCaptureDevicePositionFront
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) dispatch_queue_t bufferQueue;
@property (nonatomic, strong) AVCaptureVideoDataOutput * dataOutput;
@property (nonatomic, strong) NSMutableArray *observerArray;
@property (nonatomic, copy) AVCaptureSessionPreset sessionPreset;  // default 1280x720
@property (nonatomic, strong) AVCaptureDeviceInput * deviceInput;
@end;

@implementation HBCameraManager
#pragma mark - Lifetime
-(void)dealloc {
    self.observerArray = nil;
    _session = nil;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setupCaptureSession];
        self.observerArray = [NSMutableArray array];
//        _isFirstApply = true;
    }
    return self;
}
// request for authorization first
- (void)_setupCaptureSession {
    [self _requestCameraAuthorization:^(BOOL granted) {
        if (granted) {
            [self __setupCaptureSession];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:BEEffectCameraDidAuthorizationNotification object:nil userInfo:nil];
        } else {
//            [self _throwError:VideoCaptureErrorAuthNotGranted];
            NSLog(@"VideoCaptureErrorAuthNotGranted");
        }
    }];
}
#pragma mark - Private
- (void)_requestCameraAuthorization:(void (^)(BOOL granted))handler {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            handler(granted);
        }];
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        handler(true);
    } else {
        handler(false);
    }
}
- (void)__setupCaptureSession {
    _session = [[AVCaptureSession alloc] init];
    [_session beginConfiguration];
    if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [_session setSessionPreset:AVCaptureSessionPreset1280x720];
        _sessionPreset = AVCaptureSessionPreset1280x720;
    } else {
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        _sessionPreset = AVCaptureSessionPresetHigh;
    }
    [_session commitConfiguration];
    _device = [self _cameraDeviceWithPosition:AVCaptureDevicePositionFront];
    _devicePosition = AVCaptureDevicePositionFront;
    _bufferQueue = dispatch_queue_create("HTSCameraBufferQueue", NULL);
    
    // Input
    NSError *error = nil;
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (!_deviceInput) {
//        [_delegate videoCapture:self didFailedToStartWithError:VideoCaptureErrorFailedCreateInput];
        return;
    }
    
    // Output
    int iCVPixelFormatType = _isOutputWithYUV ? kCVPixelFormatType_420YpCbCr8BiPlanarFullRange : kCVPixelFormatType_32BGRA;
    _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_dataOutput setAlwaysDiscardsLateVideoFrames:YES];
    [_dataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:iCVPixelFormatType] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [_dataOutput setSampleBufferDelegate:self queue:_bufferQueue];
    
    [_session beginConfiguration];
    if ([_session canAddOutput:_dataOutput]) {
        [_session addOutput:_dataOutput];
    } else {
//        [self _throwError:VideoCaptureErrorFailedAddDataOutput];
        NSLog( @"Could not add video data output to the session" );
    }
    if ([_session canAddInput:_deviceInput]) {
        [_session addInput:_deviceInput];
    }else{
//        [self _throwError:VideoCaptureErrorFailedAddDeviceInput];
        NSLog( @"Could not add device input to the session" );
    }
    [_session commitConfiguration];
    AVCaptureConnection *videoConnection =  [_dataOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([videoConnection isVideoOrientationSupported]) {
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    if ([videoConnection isVideoMirroringSupported]) {
        [videoConnection setVideoMirrored:YES];
    }
//    [self registerNotification];
//    [self startRunning];
}
- (AVCaptureDevice *)_cameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    AVCaptureDevice *deviceRet = nil;
    if (position != AVCaptureDevicePositionUnspecified) {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in devices) {
            if ([device position] == position) {
                deviceRet = device;
            }
        }
    }
    return deviceRet;
}
#pragma mark - Public
- (void)startRunning {
    if (!_dataOutput) {
        return;
    }
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
}

- (void)stopRunning {
    if (_session && [_session isRunning]) {
        [_session stopRunning];
    }
}
#pragma mark - AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    if (!_isPaused) {
        if (_delegate && [_delegate respondsToSelector:@selector(videoCapture:didOutputSampleBuffer:)]) {
            [_delegate videoCapture:self didOutputSampleBuffer:sampleBuffer];
        }
//    }
}
@end
