//
//  RACSubjectViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACSubjectViewController.h"
#import "ReactiveObjC.h"

@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // RACSubject：热信号的源头，继承于RACSignal
    // RACSubject类中在发送信号时，RACSubject类会将所有的订阅者信号全部遍历并发送一次
    RACSubject *subject = [RACSubject subject];

    // Subscriber 1
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"1st Sub: %@", x);
    }];
    [subject sendNext:@1];

    // Subscriber 2
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"2nd Sub: %@", x);
    }];
    [subject sendNext:@2];

    // Subscriber 3
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"3rd Sub: %@", x);
    }];
    [subject sendNext:@3];
    [subject sendCompleted];
    
    
    // 热信号和冷信号
    // 冷信号是被动的，只会在被订阅时向订阅者发送通知；热信号是主动的，它会在任意时间发出通知，与订阅者的订阅时间无关
}



@end
