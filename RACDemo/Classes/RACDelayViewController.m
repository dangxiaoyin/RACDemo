//
//  RACDelayViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACDelayViewController.h"
#import "ReactiveObjC.h"


@interface RACDelayViewController ()
@property (nonatomic, strong) RACSignal *signal;

@end

@implementation RACDelayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 定时执行:  每一秒执行一次,这里要加上释放信号,否则控制器推出后依旧会执行
    [[[RACSignal interval:1 onScheduler:[RACScheduler scheduler]]takeUntil:self.rac_willDeallocSignal ] subscribeNext:^(id x) {
        NSLog(@"%@",[NSDate date]);
    }];
    
    // 延时执行
    [[self.signal delay:2] subscribeNext:^(id x) {
        NSLog(@"%@",[NSDate date]);
    }];
    
    
    // 信号发送失败后会重新执行
    [[self.signal retry] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    // 当一个信号被多次订阅时,不会每次都执行一遍副作用,而是像热信号一样只执行一遍,replay内部将信号封装RACMulticastConnection的热信号
    // 说明了冷信号的本质以及副作用,每订阅一次冷信号,都会完整的执行一次副作用
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        static int a = 1;
        [subscriber sendNext:@(a)];
        a ++;
        return nil;

    }];

    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅者%@",x);
    }];

    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅者%@",x);
    }];
    
    
    // 节流
    // 对信号使用throttle这个方法,原理就是类似若一段时间后没有新信号就执行最后这个信号,前面讲的即时搜索的优化就是一个很好的例子,主要用在降低服务器压力以及其他一些信号发送频繁,但订阅却不需要如此频繁的地方
    [[self.signal throttle:1] subscribeNext:^(id x) {

        NSLog(@"%@",x);

    }];
}




@end
