//
//  HBSwizzlingViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/17.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBSwizzlingViewController.h"
#import "HBSwizzlingViewController+HBSwizzling.h"
@interface HBSwizzlingViewController ()

@end

@implementation HBSwizzlingViewController

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
- (void)swizzling_sunli {
//    [self sunli];
    NSLog(@"HBSwizzlingViewController------swizzling_sunli");
}
@end
