//
//  RACSequenceViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACSequenceViewController.h"
#import "ReactiveObjC.h"

@interface RACSequenceViewController ()

@end

@implementation RACSequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *arr = @[];
    
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@,%@",x,[NSThread currentThread]);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    } completed:^{
        NSDictionary *dict = @{};
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
                
                // RACTupleUnpack宏：专门用来解析元组
                // RACTupleUnpack 等式右边：需要解析的元组
                // 宏的参数，填解析的什么样数据 元组里面有几个值，宏的参数就必须填几个
                // 非主线程

                RACTupleUnpack(id key, id value) = x;
                NSLog(@"%@,%@,%@",key,value,[NSThread currentThread]);
            } completed:^{
                NSLog(@"字典解析完成");
            }];
        });
    }];
}


@end
