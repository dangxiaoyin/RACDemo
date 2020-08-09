//
//  RACViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACViewController.h"
#import "ReactiveObjC.h"

@interface RACViewController ()

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
}

/**
 * RAC：响应式编程
 *
 * RAC 三步：
 * 1、创建信号  2、订阅信号  3、发送信号
 *
 * 1、创建信号之前先订阅
 * 2、发送信号之前先订阅
 */
- (void)signal {
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 发送信号在创建信号完成的block中进行
        [subscriber sendNext:@"a signal"];
        
        // 自动取消信号
        return nil;
    }];
    
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@" -- %@", x);
    }];
    
    
    // 合并到一块写
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@""];
        return nil;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"");
    }];
    
    // 信号结束自动取消，如果在这里调用了subscriber对象，将不会自动取消
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@""];
        
        // 在这里强引用subscriber 将不会再自动取消
        self.subscriber = subscriber;
        
        // 这里需手动取消
        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            NSLog(@"已取消订阅信号");
        }];
        return disposable;
        
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号 ");
    }];

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
