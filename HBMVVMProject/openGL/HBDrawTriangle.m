//
//  HBDrawTriangle.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/6/5.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBDrawTriangle.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES3/glext.h>
/*
 1.uniform变量

 uniform变量是外部application程序传递给（vertex和fragment）shader的变量。因此它是application通过函数glUniform**（）函数赋值的。在（vertex和fragment）shader程序内部，uniform变量就像是C语言里面的常量（const ），它不能被shader程序修改。（shader只能用，不能改）

 如果uniform变量在vertex和fragment两者之间声明方式完全一样，则它可以在vertex和fragment共享使用。（相当于一个被vertex和fragment shader共享的全局变量）

 uniform变量一般用来表示：变换矩阵，材质，光照参数和颜色等信息。

 以下是例子：

 uniform mat4 viewProjMatrix; //投影+视图矩阵
 uniform mat4 viewMatrix;        //视图矩阵
 uniform vec3 lightPosition;     //光源位置
 2.attribute变量

 attribute变量是只能在vertex shader中使用的变量。（它不能在fragment shader中声明attribute变量，也不能被fragment shader中使用）

 一般用attribute变量来表示一些顶点的数据，如：顶点坐标，法线，纹理坐标，顶点颜色等。

 在application中，一般用函数glBindAttribLocation（）来绑定每个attribute变量的位置，然后用函数glVertexAttribPointer（）为每个attribute变量赋值。

 以下是例子：

 uniform mat4 u_matViewProjection;
 attribute vec4 a_position;
 attribute vec2 a_texCoord0;
 varying vec2 v_texCoord;
 void main(void)
 {
 gl_Position = u_matViewProjection * a_position;
 v_texCoord = a_texCoord0;
 }
 3.varying变量
 varying变量是vertex和fragment shader之间做数据传递用的。一般vertex shader修改varying变量的值，然后fragment shader使用该varying变量的值。因此varying变量在vertex和fragment shader二者之间的声明必须是一致的。application不能使用此变量。

 以下是例子：

 // Vertex shader
 uniform mat4 u_matViewProjection;
 attribute vec4 a_position;
 attribute vec2 a_texCoord0;
 varying vec2 v_texCoord; // Varying in vertex shader
 void main(void)
 {
 gl_Position = u_matViewProjection * a_position;
 v_texCoord = a_texCoord0;
 }


 // Fragment shader
 precision mediump float;
 varying vec2 v_texCoord; // Varying in fragment shader
 uniform sampler2D s_baseMap;
 uniform sampler2D s_lightMap;
 void main()
 {
 vec4 baseColor;
 vec4 lightColor;
 baseColor = texture2D(s_baseMap, v_texCoord);
 lightColor = texture2D(s_lightMap, v_texCoord);
 gl_FragColor = baseColor * (lightColor + 0.25);
 }

 */



const char *vertexShaderSource ="attribute vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";
const char *fragmentShaderSource ="precision lowp float;\n"
"vec4 videoColor;\n"
"void main()\n"
    "{\n"
    "videoColor =  vec4(1.0, 0.5, 0.2, 1.0);\n"
    "gl_FragColor = videoColor;\n"
    "}\n\0";
@interface HBDrawTriangle() {
    int shaderProgram;
    unsigned int VAO;
}
@end;

@implementation HBDrawTriangle
- (void)dealloc {
    glDeleteVertexArrays(1, &VAO);
//    glDeleteBuffers(1, &VBO);
//    glDeleteBuffers(1, &EBO);
}
- (instancetype)init {
    if (self == [super init]) {
        [self createShader];
    }
    return self;
}
-(void)createShader{
    // 创建编译顶点着色器
    int vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);
    // check for shader compile errors
    GLint success;
    char infoLog[512];
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
        NSLog(@"ERROR::SHADER::VERTEX::%s\n",infoLog);
    }
    //创建编译片段着色器
    int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);
    // check for shader compile errors
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
        NSLog(@"ERROR::SHADER::FRAGMENT::%s\n",infoLog);
    }
    //创建shader程序 连接顶点片段着色器 连接shader程序
    shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);
    // check for linking errors
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
        NSLog(@"ERROR::SHADER::PROGRAM::%s\n",infoLog);
    }
    //链接完成着shader程序之后删除着色器程序
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    // set up vertex data (and buffer(s)) and configure vertex attributes
    //顶点数组
    float vertices[] = {
         0.5f,  0.5f, 0.0f,  // top right
         0.5f, -0.5f, 0.0f,  // bottom right
        -0.5f, -0.5f, 0.0f,  // bottom left
        -0.5f,  0.5f, 0.0f   // top left
    };
    //索引数组
    unsigned int indices[] = {  // note that we start from 0!
        0, 1, 3,  // first Triangle
        1, 2, 3   // second Triangle
    };
    //创建顶点缓冲对象 顶点数组对象 索引缓冲对象
    unsigned int VBO, EBO;
    glGenVertexArrays(1, &VAO);
    // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).
    glBindVertexArray(VAO);
    
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);
    
    //绑定顶点缓冲区 copy顶点数据到顶点缓冲区对象
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    //绑定顶点索引缓冲区 copy顶点索引数据到顶点索引缓冲区
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
       
    GLuint loc=glGetAttribLocation(shaderProgram, "aPos");   //获得shader里position变量的索引
    //设置顶点属性指针 解释顶点数据 顶点索引获取顶点数据
    glVertexAttribPointer(loc, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(loc);

    glBindVertexArray(0);   //释放vao
    glBindBuffer(GL_ARRAY_BUFFER, 0);  //释放vbo
    [self checkGLError];
}
- (void)draw {
   glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
   glClear(GL_COLOR_BUFFER_BIT);
//// draw our first triangle
   glUseProgram(shaderProgram);
   glBindVertexArray(VAO); // seeing as we only have a single VAO there's no need to bind it every time, but we'll do so to keep things a bit more organized
//   glDrawArrays(GL_TRIANGLES, 0, 3); //需要绑定顶点数据
   glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0); //需要绑定顶点索引数据
    
   glBindVertexArray(0); //释放vao
   glBindBuffer(GL_ARRAY_BUFFER, 0);//释放vbo
   glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);////释放索引对象
}
- (void)checkGLError {
    int error = glGetError();
    if (error != GL_NO_ERROR) {
        NSLog(@"checkGLError code is:%x\n", error);
    }
}
@end
