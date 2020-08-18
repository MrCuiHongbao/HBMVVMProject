//
//  NSGLSharder.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "NSGLSharder.h"

NSString *RENDER_VERTEX = CHB_SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 varying vec2 textureCoordinate;
 void main(){
     textureCoordinate = inputTextureCoordinate.xy;
     gl_Position = position;
 }
 );

NSString *RENDER_FRAGMENT = CHB_SHADER_STRING
(
 precision mediump float;
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 void main()
 {
     gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
 }
 );

@implementation NSGLSharder
@end
