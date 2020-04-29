//
//  HBBlockViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/4/9.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBBlockViewController.h"

@interface HBBlockViewController ()

@end

@implementation HBBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_queue_t serialQueue = dispatch_queue_create("com.hb.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block_t_0 = dispatch_block_create(0, ^{
            NSLog(@"开始第一个任务");
           [NSThread sleepForTimeInterval:1.5f];
           NSLog(@"结束第一个任务");
    });
    dispatch_block_t block_t_1 = dispatch_block_create(0, ^{
            NSLog(@"开始第二个任务");
           [NSThread sleepForTimeInterval:1.5f];
           NSLog(@"结束第二个任务");
    });
    dispatch_async(serialQueue, block_t_0);
    dispatch_async(serialQueue, block_t_1);
    
    // 等待 1s，让第一个任务开始运行
    [NSThread sleepForTimeInterval:1];

    dispatch_block_cancel(block_t_0);
    NSLog(@"尝试过取消第一个任务");

    dispatch_block_cancel(block_t_1);
    NSLog(@"尝试过取消第二个任务");
    
//    dispatch_group_wait(<#dispatch_group_t  _Nonnull group#>, <#dispatch_time_t timeout#>)
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
