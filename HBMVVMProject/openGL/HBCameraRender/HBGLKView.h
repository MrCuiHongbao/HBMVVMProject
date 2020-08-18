//
//  HBGLKView.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/12.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, PixelBufferType) {
    PixelBufferTypeNone,
    PixelBufferTypeYUV,
    PixelBufferTypeRGBA,
};

NS_ASSUME_NONNULL_BEGIN

@interface HBGLKView : GLKView

- (instancetype)initWithFrame:(CGRect)frame  withEAGLContext:(EAGLContext *)context withPixelBufferType:(PixelBufferType)pixelType;

- (void) getTextureFromBuffer:(CVPixelBufferRef)pixelBuf;
@end

NS_ASSUME_NONNULL_END
