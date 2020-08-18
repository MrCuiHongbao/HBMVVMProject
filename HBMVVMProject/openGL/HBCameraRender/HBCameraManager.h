//
//  HBCameraManager.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/16.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class HBCameraManager;

typedef NS_ENUM(NSInteger, VideoCaptureError) {
    VideoCaptureErrorAuthNotGranted = 0,
    VideoCaptureErrorFailedCreateInput = 1,
    VideoCaptureErrorFailedAddDataOutput = 2,
    VideoCaptureErrorFailedAddDeviceInput = 3,
};

@protocol HBVideoCaptureDelegate <NSObject>
- (void)videoCapture:(HBCameraManager *_Nullable)camera didOutputSampleBuffer:(CMSampleBufferRef _Nonnull )sampleBuffer;
- (void)videoCapture:(HBCameraManager *_Nonnull)camera didFailedToStartWithError:(VideoCaptureError)error;
@end
NS_ASSUME_NONNULL_BEGIN

@interface HBCameraManager : NSObject
@property (nonatomic, weak) id <HBVideoCaptureDelegate> delegate;
@property (nonatomic, assign) BOOL isOutputWithYUV; // default NO

- (void)startRunning;
- (void)stopRunning;
@end

NS_ASSUME_NONNULL_END
