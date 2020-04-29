//
//  MineViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "MineViewController.h"
#import <objc/runtime.h>
#import "HBNSLog.h"
@interface MineViewController ()
//@property(nonatomic,assign)int max;
@end

@implementation MineViewController
+(void)load {
    NSLog(@"MineViewController");
}
+(void)initialize {
    NSLog(@"MineViewController--------------->initialize");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MineViewController--------------->viewDidLoad");
    Class  class = object_getClass(self);
    NSLog(@"class name is:%@",class);

    NSLog(@"self.class name is:%@",self.class);

    
    NSLog(@"self.superClass name is:%@",self.superclass);

    NSLog(@"self.class_getSuperclass name is:%@",class_getSuperclass(self.class));
    
    
    NSLog(@"self.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.class).UTF8String));

    
    NSLog(@"self.superclass.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.superclass).UTF8String));

    NSLog(@"self.superclass.superClass.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.superclass.superclass).UTF8String));

    NSLog(@"self.superclass.superClass.superClass.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.superclass.superclass.superclass).UTF8String));

    
    NSLog(@"self.superclass.superClass.superClass.superClass.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.superclass.superclass.superclass.superclass).UTF8String));

    NSLog(@"self.superclass.superClass.superClass.superClass.superClass.objc_getMetaClass name is:%@",objc_getMetaClass(NSStringFromClass(self.superclass.superclass.superclass.superclass.superclass).UTF8String));

    // Do any additional setup after loading the view.
//    NSString *str = @"8888888888888";
//    char asciiChars[100];
//    memcpy(asciiChars, [str cStringUsingEncoding:NSASCIIStringEncoding], 2*[str length]);
//
//    NSMutableString *sting = [[NSMutableString alloc] initWithCapacity:1.0];
//    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
//    UIColor *imageColor = [UIColor colorWithPatternImage:image];
//    const CGFloat *components = CGColorGetComponents(imageColor.CGColor);
//    int count=0;
//    for (int w=0; w<image.size.width; w++) {
//        for (int h =0; h <image.size.height; h++) {
//            NSLog(@"Red: %f", components[0]);
//            NSLog(@"Green: %f", components[1]);
//            NSLog(@"Black: %f", components[2]);
//            int index = (components[0]* 10) / 255;
//            NSString *a = [NSString stringWithCString:&asciiChars[index] encoding:NSUTF8StringEncoding];
//            [sting appendString:a];
////          sting.Append(asciiChars[index]);
//            NSLog(@"count----------->%d",count++);
//        }
//        [sting appendString:@"\r\n"];   //一行结束，加一个回车换行
//    }
//    NSLog(@"%@",sting);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
