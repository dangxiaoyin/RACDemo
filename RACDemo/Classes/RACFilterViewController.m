//
//  RACFilterViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACFilterViewController.h"
#import "ReactiveObjC.h"

@interface RACFilterViewController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation RACFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        
    
}

// 过滤信号，使用它可以获取满足条件的信号.
- (void)filter
{
    // 当我们文本框内容长度大于5才想要获取文本框的内容
    [[_textField.rac_textSignal filter:^BOOL(id value) {
        //value:源信号的内容
        return [value length] > 5;
        //返回值就是过滤的条件,只有满足这个条件才能获取到内容
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

}

// 忽略完某些值的信号.
- (void)ignore
{
    //创建信号
        RACSubject *subject = [RACSubject subject];
        //ignore:忽略一些值
        //ignoreValues:忽略所有值
        RACSignal *ignoreSignal = [subject ignore:@"HMJ"];
    //    RACSignal *ignoreSignal = [subject ignoreValues];
        //订阅信号
        [ignoreSignal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        //发送信号
        [subject sendNext:@"HMJ"];
        [subject sendNext:@"WGQ"];
}

// 当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
// 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
- (void)distinctUntilChanged
{
    //distinctUntilChanged:如果当前的值跟上一个值相同就不会被调用到
    //创建信号
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"HMJ"];
}


// 从开始一共取N次的信号
- (void)take
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    //take:取前面几个值
    //在没到第三个时就遇到[subject sendCompleted];那么就会停止发送信号
    [[subject take:3] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //takeLast:取后面多少个值,必须发送完成
    //只有[subject sendCompleted];才会发送信号
    [[subject takeLast:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //takeUntil:只要传入的信号发送完成或者signal发送信号,就不会再接收信号的内容
    [[subject takeUntil:signal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //发送任意数据
    [subject sendNext:@1];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@3];
    [subject sendCompleted];
    [subject sendNext:@4];
    [signal sendNext:@"signal"];
}


// 用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号
- (void)switchToLatest
{
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    // 获取信号中信号最近发出信号，订阅最近发出的信号。
    // 注意switchToLatest：只能用于信号中的信号
    //订阅信号
    [signalOfSignal.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //发送信号
    [signalOfSignal sendNext:signal];
    [signal sendNext:@"signal"];
}


// 跳过几个信号,不接受
- (void)skip
{
    //skip:跳跃几个值再接收被订阅
    //创建信号
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"1"];
    [subject sendNext:@"3"];
}



@end
