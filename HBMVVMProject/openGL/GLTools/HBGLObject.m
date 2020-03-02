//
//  HBGLObject.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/2/20.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLObject.h"

@implementation HBGLObject
- (id)initWithGLContext:(HBGLToolContext *)context {
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (void)update:(NSTimeInterval)timeSinceLastUpdate {

}

- (void)draw:(HBGLToolContext *)glContext {
    
}
@end
