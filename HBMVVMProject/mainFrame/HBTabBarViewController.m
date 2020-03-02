//
//  HBTabBarViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/2.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBTabBarViewController.h"
#import "HBRouter.h"
#import "HBNavigationController.h"
@interface HBTabBarViewController ()
@end

@implementation HBTabBarViewController
- (UIImage *)resizeImage:(UIImage *)iconImage size:(CGSize)itemSize {
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [iconImage drawInRect:imageRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (instancetype)initWithViewControllers:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSMutableArray *viewsVC = [NSMutableArray arrayWithCapacity:1.0];
        NSArray *views = [dict objectForKey:@"HBTabBarModule"];
        NSArray *imageICons = [dict objectForKey:@"HBTabBarIconName"];
        NSArray *imageTitles = [dict objectForKey:@"HBTabBarTitle"];
        NSInteger index = 0;
        for (NSString *className in views) {
            NSString *classFormate = [NSString stringWithFormat:@"router://%@/%@exportInterface",className,className];
            UIViewController  *vc = [HBRouter openURL:classFormate arg:nil error:nil completion:^(id  _Nullable object) {
                NSLog(@"object----->%@",object);
            }];
            if (vc) {
                HBNavigationController  *nav = [HBRouter openURL:@"router://HBNavModule/HBNavModuleexportInterface" arg:@{@"rootVC":vc} error:nil completion:^(id  _Nullable object) {
                    NSLog(@"object----->%@",object);
                }];
                if (nav) {
                    [viewsVC addObject:nav];
                }
            }
            NSString *imageName = @"";
            if (views.count <=imageICons.count) {
                imageName = [imageICons objectAtIndex:index];
            }
            NSString *title = @"";
            if (views.count <=imageTitles.count) {
                title = [imageTitles objectAtIndex:index];
            }
            UIImage *image = [UIImage imageNamed:imageName];
            image = [self resizeImage:image size:CGSizeMake(45.0, 45.0)];
            vc.tabBarItem.image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.title = title;
            vc.navigationItem.title = title;
            index++;
        }
        self.viewControllers = viewsVC;
        self.customizableViewControllers = viewsVC;
//        [self.tabBar setItems:items animated:YES];
//        unsigned int i = 0x123456ab;
//        unsigned char *pi = (unsigned char *)&i;
//        for (int i=0; i<sizeof(i); i++) {
//            printf("\n---0x123456ab-----%X",*pi++);
//        }
//        char *j = "jdms\0";
//        printf("\n%lu,%lu",strlen(j),sizeof(j));
//
//        char* ss = "0123456789";
//        printf("\n%lu",sizeof(char));
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
