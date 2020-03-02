//
//  JDARVRGLObject.m
//  OpenGLESLearn
//
//  Created by wang yang on 2017/5/16.
//  Copyright © 2017年 wangyang. All rights reserved.
//

#import "JDARVRGLObject.h"

@implementation JDARVRGLObject
- (id)initWithGLContext:(JDARVRGLContext *)context {
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (void)update:(NSTimeInterval)timeSinceLastUpdate {

}

- (void)draw:(JDARVRGLContext *)glContext {
    
}
@end
