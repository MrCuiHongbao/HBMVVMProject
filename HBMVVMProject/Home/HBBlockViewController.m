//
//  HBBlockViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/4/9.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBBlockViewController.h"
#import <mach/task.h>
#import <mach/mach.h>

@interface HBBlockViewController ()

@end

@implementation HBBlockViewController
// 当前 app 内存使用量
- (NSInteger)useMemoryForApp {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (kernelReturn == KERN_SUCCESS) {
        int64_t memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        return memoryUsageInByte / 1024 / 1024;
    } else {
        return -1;
    }
}
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
    
    NSInteger useMemoryForApp = [self useMemoryForApp];
    NSLog(@"当前使用内存:%dM",useMemoryForApp);
}
- (void)saySomething {
    NSLog(@"NB %s-%d",__func__,self.editing);
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
