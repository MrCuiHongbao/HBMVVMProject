//
//  DisplayViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "DisplayViewController.h"
#import "ReactiveObjC.h"
@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    [self requestData];
}
-(void)requestData
{
//网络请求1
//    1.创建信号
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"网络请求1");
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        // 2.发送信号
        [subscriber sendNext:@"网络请求1"];
// 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
//          [subscriber sendCompleted];
        return  [RACDisposable disposableWithBlock:^{
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
//网络请求2
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"网络请求2");
        [subscriber sendNext:@"网络请求2"];
        return  nil;
    }];
 
//网络请求3
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"网络请求3");
        [subscriber sendNext:@"网络请求3"];
        return  nil;
    }];
    [self rac_liftSelector:@selector(dealDataWithData1:data2:data3:) withSignals:signal1,signal2,signal3,nil];
    
    // 3.订阅信号,才会激活信号.
    [signal1 subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
    [signal2 subscribeNext:^(id  _Nullable x) {
        
    }];
    [signal3 subscribeNext:^(id  _Nullable x) {
        
    }];
}
 
-(void)dealDataWithData1:(id)data1 data2:(id)data2 data3:(id)data3
{
//三个网络请求结束后在这里处理数据
 
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
