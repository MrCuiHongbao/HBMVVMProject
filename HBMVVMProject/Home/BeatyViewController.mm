//
//  BeatyViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/4/6.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "BeatyViewController.h"
#include <opencv2/opencv.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

//#include <string>
#include <map>
#include <iostream>
#import <WebKit/WebKit.h>
using namespace std;

const char codeLib[] = "@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. ";
@interface BeatyViewController ()

@end
@implementation BeatyModel

@end
@implementation BeatyViewController
- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat {
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    CGBitmapInfo bitmapInfo;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
        bitmapInfo = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
        bitmapInfo = kCGBitmapByteOrder32Little | (
                                                   cvMat.elemSize() == 3? kCGImageAlphaNone : kCGImageAlphaNoneSkipFirst
                                                   );
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(
                                        cvMat.cols,                 //width
                                        cvMat.rows,                 //height
                                        8,                          //bits per component
                                        8 * cvMat.elemSize(),       //bits per pixel
                                        cvMat.step[0],              //bytesPerRow
                                        colorSpace,                 //colorspace
                                        bitmapInfo,                 // bitmap info
                                        provider,                   //CGDataProviderRef
                                        NULL,                       //decode
                                        false,                      //should interpolate
                                        kCGRenderingIntentDefault   //intent
                                        );
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}
- (cv::Mat)cvMatWithImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to backing data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    BeatyModel *model = [[BeatyModel alloc] init];
    model.data = 1;
    model.number = 2;
    NSArray *array = [NSMutableArray  arrayWithObjects:@"1234", @"5674",model,nil];
    NSMutableArray *copyArray = array.mutableCopy;
    BeatyModel *copy_model = [copyArray objectAtIndex:2];
    copy_model.data =5;
    
                                 
   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"smile" ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
   const char * path = [filePath cStringUsingEncoding:NSUTF8StringEncoding];
    cv::Mat srcImg = cv::imread(path);////读取一张图片

    cv::Mat grayImg;
    cvtColor(srcImg, grayImg, cv::COLOR_RGB2GRAY);//将图片转成灰度图
    UIImage *grayImage = [self UIImageFromCVMat:grayImg];
    
    
    std::string str;    //定义一个用来存储图片转换的字符的字符串
    NSMutableString *fff = [NSMutableString string];
    int count=0;
    //循环遍历(灰度图)图片的每一个像素点
    for(int y = 0; y < grayImg.rows; y++) {
        for (int x = 0; x < grayImg.cols; x++) {
            int grayVal = (int)grayImg.at<uchar>(y, x);
            //获取每个像素点的灰度值，并根据灰度值对应ASCII字符数组中的的字符
            //这里的69是定义的ASCII字符数组的长度，我直接写了
            int index = 69.0/ 255.0 * grayVal;
//            printf("%c",codeLib[index])
            NSString *ttt = [NSString stringWithFormat:@"%c",codeLib[index]];
            [fff appendFormat:@"%@",ttt];
        }
//        str += "\r\n";
        [fff appendFormat:@"\r\n"];
        count++;
        NSLog(@"count------------>%d",count);
        NSLog(@"grayImg.cols----->%d",grayImg.cols);
    }
//    NSString *stringText= [NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding];
//    UITextView *txtView = [[UITextView alloc] initWithFrame:self.view.bounds];
//    txtView.text = fff;
//    [self.view addSubview:txtView];
//    UILabel *phLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
//    phLabel.text = stringText;
//    [self.view addSubview:phLabel];

    NSData *fileData = [fff dataUsingEncoding:NSUTF8StringEncoding];

    NSString *file_Path = [self getCreateFolder:@"HBMVVMProject"];
    file_Path = [file_Path stringByAppendingString:@"/photo.txt"];
   BOOL ix = [fileData writeToFile:file_Path atomically:YES];
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:file_Path encoding:NSUTF8StringEncoding error:nil];
//    htmlString = [self adaptWebViewForHtml:htmlString];
//    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//    [self.view addSubview:webView];
    
//    [[NSString alloc] initWithContentsOfURL:<#(nonnull NSURL *)#> usedEncoding:<#(nullable NSStringEncoding *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>];
//    NSString *fileSSS = [[NSString alloc] initWithContentsOfFile:file_Path usedEncoding:NSUTF8StringEncoding error:nil];
    
//    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc]initWithString:fff];
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
////    paraStyle.alignment = NSTextAlignmentJustified;//两端对齐
//    paraStyle.paragraphSpacing = 0.0;//行后间距
//    NSDictionary *dic = @{
//                          NSForegroundColorAttributeName:[UIColor blackColor],
//                          NSFontAttributeName:[UIFont systemFontOfSize:1],
//                          NSParagraphStyleAttributeName:paraStyle,
//                          };
//    [mutaString setAttributes:dic range:NSMakeRange(0, mutaString.length)];
    
    
//    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
//    [label setFont:[UIFont systemFontOfSize:4.0]];
//    [self.view addSubview:label];
//    [label setTextAlignment:NSTextAlignmentLeft];
//    [label setNumberOfLines:0];
//    [label setText:fff];
////    [label setAttributedText:mutaString];
//    [label setAdjustsFontSizeToFitWidth:YES];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
    [textView setAdjustsFontForContentSizeCategory:YES];
    [textView setFont:[UIFont systemFontOfSize:4.0]];
    [self.view addSubview:textView];
    textView.text = fff;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [label sizeToFit];
}
//HTML适配图片文字
- (NSString *)adaptWebViewForHtml:(NSString *) htmlStr {
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    [headHtml appendString : @"<html>" ];
    [headHtml appendString : @"<head>" ];
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];
    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];
    //适配图片宽度，让图片宽度等于屏幕宽度
    //[headHtml appendString : @"<style>img{width:100%;}</style>" ];
    //[headHtml appendString : @"<style>img{height:auto;}</style>" ];
    //适配图片宽度，让图片宽度最大等于屏幕宽度
//    [headHtml appendString : @"<style>img{max-width:100%;width:auto;height:auto;}</style>"];
    //适配图片宽度，如果图片宽度超过手机屏幕宽度，就让图片宽度等于手机屏幕宽度，高度自适应，如果图片宽度小于屏幕宽度，就显示图片大小
    [headHtml appendString : @"<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var maxwidth=document.body.clientWidth;\n" //屏幕宽度
     "for(i=0;i <document.images.length;i++){\n"
     "var myimg = document.images[i];\n"
     "if(myimg.width > maxwidth){\n"
     "myimg.style.width = '100%';\n"
     "myimg.style.height = 'auto'\n;"
     "}\n"
     "}\n"
     "}\n"
     "</script>\n"];
    [headHtml appendString : @"<style>table{width:100%;}div{font-size:1px}</style>" ];
    [headHtml appendString : @"<title>webview</title>" ];
    [headHtml appendString : @"</head>" ];
    [headHtml appendString:@"<body>"];
    [headHtml appendString:@"<div>"];
    [headHtml appendString:htmlStr];
    [headHtml appendString:@"</div>"];
    [headHtml appendString:@"</body>"];
    [headHtml appendString:@"</html>"];
//    NSString *bodyHtml;
//    bodyHtml = [NSString stringWithString:headHtml];
//    bodyHtml = [bodyHtml stringByAppendingString:htmlStr];
    
    
    
    return headHtml;
}
-(NSString *)getCreateFolder:(NSString*)file
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *subPath = [documentPath stringByAppendingPathComponent:file];
    NSLog(@"getCreateFolder:%@",documentPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:subPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return subPath;
}
//将字符串写入文件
void outToFile(const char *fileName, const string content){
//    ofstream outStream;
//    ofstream outStream;
//    outStream.open(fileName);
//    outStream << content << std::endl;
//    outStream.close();
    
//    dispatch_block_cancel(<#^(void)block#>)
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
