//
//  OpenGLViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/22.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "OpenGLViewController.h"
#import <GLKit/GLKit.h>
#import "HBGLTool.h"
typedef struct {
   GLKVector3  positionCoords;
}SceneVertex;
@interface OpenGLViewController ()<GLKViewDelegate>
@property(nonatomic,strong)GLKView *glkView;
@property(nonatomic,strong)EAGLContext *currentContext;
@property(nonatomic,strong)HBGLTool *tool;
@end

@implementation OpenGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initGLKView];
//    [self initVertexAndFragment];
}
//- (void)initVertexAndFragment {
//
//
//}
- (void)initGLKView {
    
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (context == nil) {
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    self.currentContext = context;
    
//    SceneVertex  vertices[] = {
//        {{-1.0,-1.0,0.0}},
//        {{1.0,-1.0,0.0}},
//        {{0.0,1.0,0.0}}
//    };
    
    self.glkView = [[GLKView alloc] initWithFrame:self.view.frame context:context];
    self.glkView.delegate = self;
    _glkView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [self.view addSubview:self.glkView];
    
    self.tool = [[HBGLTool alloc] init];
    [_tool setup];
    
//    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self.glkView selector:@selector(display)];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
#pragma GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
//    glClearColor(1.0, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    NSLog(@"drawInRect");
    [_tool draw];
//    glDrawArrays(GL_TRIANGLES, 0, 3);
}
@end
