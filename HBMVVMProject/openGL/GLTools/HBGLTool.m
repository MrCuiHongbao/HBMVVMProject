//
//  HBGLTool.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/2/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLTool.h"
#import "HBGLToolContext.h"
#import "HBGLDrawTools.h"
@interface HBGLTool()
@property(nonatomic,strong)HBGLToolContext *toolsContext;
@property(nonatomic,strong)HBGLDrawTools *drawTools;
@end
@implementation HBGLTool
- (void)setup {
//    NSBundle *moduleBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ThreeDProductModule" ofType:@"bundle"]];
//     NSString *vertexShaderPath = [moduleBundle pathForResource:@"TDP_vertex.glsl"
//                                                         ofType:nil];
//     NSString *fragmentShaderPath = [moduleBundle pathForResource:@"TDP_frag_video.glsl" ofType:nil];
    NSString *vertexShaderPath = [[NSBundle mainBundle] pathForResource:@"SimpleVertex" ofType:@"glsl"];
    NSString *fragmentShaderPath =[[NSBundle mainBundle] pathForResource:@"SimpleFragment" ofType:@"glsl"];
     self.toolsContext = [HBGLToolContext contextWithVertexShaderPath:vertexShaderPath fragmentShaderPath:fragmentShaderPath];
     self.drawTools = [[HBGLDrawTools alloc] initWithGLContext:_toolsContext];
}

- (void)draw {
    [_drawTools draw:self.toolsContext];
}
//- (void)GLToolsCheckGLError:(const char *msg) {
//    GLenum err = glGetError();
//    if (err != GL_NO_ERROR) {
//        NSLog(@"GLToolsCheckGLError:%d",err);
//    }
//}
@end
