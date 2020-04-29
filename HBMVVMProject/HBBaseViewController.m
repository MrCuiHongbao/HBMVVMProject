//
//  HBBaseViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBBaseViewController.h"

@interface HBBaseViewController ()

@end

@implementation HBBaseViewController
+(void)load {
    NSLog(@"HBBaseViewController--------------->load");
}
+(void)initialize {
    NSLog(@"HBBaseViewController--------------->initialize");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
