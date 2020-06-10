//
//  HBGLToolContext.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/1/23.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBGLToolContext.h"
#import <GLKit/GLKit.h>

@implementation HBGLToolContext
@synthesize program;
+ (id)contextWithVertexShaderPath:(NSString *)vertexShaderPath fragmentShaderPath:(NSString *)fragmentShaderPath {
    NSString *vertexShaderContent = [NSString stringWithContentsOfFile:vertexShaderPath encoding:NSUTF8StringEncoding error:nil];
    NSString *fragmentShaderContent = [NSString stringWithContentsOfFile:fragmentShaderPath encoding:NSUTF8StringEncoding error:nil];
    return [[HBGLToolContext alloc] initWithVertexShader:vertexShaderContent fragmentShader:fragmentShaderContent];
}
- (id)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    if(self = [super init]) {
        [self setupShader:vertexShader fragmentShaderContent:fragmentShader];
    }
    return self;
}
- (void)active {
    NSLog(@"self.program------------>%d",self.program);
    glUseProgram(self.program);
}
- (void)drawTriangles:(GLfloat *)triangleData vertexCount:(GLint)vertexCount {
    [self bindAttribs:triangleData];
    glDrawArrays(GL_TRIANGLES, 0, vertexCount);
}
- (void)bindAttribs:(GLfloat *)triangleData {
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, triangleData);
    GLuint positionAttribLocation = glGetAttribLocation(self.program, "aPos");
    glEnableVertexAttribArray(positionAttribLocation);
    
    // 为shader中的position和color赋值
    // glVertexAttribPointer (GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr)
    // indx: 上面Get到的Location
    // size: 有几个类型为type的数据，比如位置有x,y,z三个GLfloat元素，值就为3
    // type: 一般就是数组里元素数据的类型
    // normalized: 暂时用不上
    // stride: 每一个点包含几个byte，本例中就是6个GLfloat，x,y,z,r,g,b
    // ptr: 数据开始的指针，位置就是从头开始，颜色则跳过3个GLFloat的大小
    //    glVertexAttribPointer(positionAttribLocation, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(GLfloat), (void *)triangleData);
    glVertexAttribPointer(positionAttribLocation, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(GLfloat), (void *)0);
}
bool create_Program(const char *vertexShader, const char *fragmentShader, GLuint *pProgram)  {
    GLuint program, vertShader, fragShader;
    program = glCreateProgram();
//    if (program == 0) {
//         return false;
//     }
    const GLchar *vssource = (GLchar *)vertexShader;
    const GLchar *fssource = (GLchar *)fragmentShader;
    if (!compile_Shader(&vertShader, GL_VERTEX_SHADER, vssource)) {
        printf("Failed to complie vertex shader");
        return false;
    }
    if (!compile_Shader(&fragShader, GL_FRAGMENT_SHADER, fssource)) {
        printf("Failed to ciomplie fragment shader");
        return false;
    }
    // Attach vertex shader to program.
    glAttachShader(program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader);
    
    if (!link_Program(program)) {
        printf("Failed to link program:%d",program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program) {
            glDeleteProgram(program);
            program = 0;
        }
    }
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(program, fragShader);
        glDeleteShader(fragShader);
    }
    *pProgram = program;
    
    return true;
}
bool compile_Shader(GLuint *shader, GLenum type, const GLchar *source) {
    GLint status;
    if (!source) {
        printf("failed to load vertex shader");
        return false;
    }
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    #if DEBUG
        if (logLength > 0) {
            GLchar *log = (GLchar *)malloc(logLength);
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            printf("Shader compile log:\n%s", log);
            printf("Shader: \n %s\n", source);
            free(log);
        }
    #endif
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status ==0) {
        glDeleteShader(*shader);
        return false;
    }
    return true;
}

bool link_Program(GLuint prog) {
    GLint status;
    glLinkProgram(prog);
#if DEBUG
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        printf("Program link log:\n%s", log);
        free(log);
    }
#endif
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return false;
    }
    return true;
}
bool validate_Program(GLuint prog) {
    GLint logLength, status;

    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        printf("Program validate log:\n%s", log);
        free(log);
    }

    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return false;
    }

    return true;
}

- (void)setupShader:(NSString *)vertexShaderContent fragmentShaderContent:(NSString *)fragmentShaderContent {
    create_Program(vertexShaderContent.UTF8String, fragmentShaderContent.UTF8String, &program);
}
@end
