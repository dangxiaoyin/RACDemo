//
//  RACKVOViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACKVOViewController.h"
#import "ReactiveObjC.h"

@interface RACKVOViewController ()

@property (nonatomic, strong) AnyObject *obj;

@end

@implementation RACKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self KVO];
}

/**
 * RAC替换KVO的用法
 * 监听对象属性变化并作出响应
 */
- (void)KVO {
    self.obj = [[AnyObject alloc] init];
        
    self.obj.dynamic = @"value";
    
    // 订阅信号执行完后 自动取消订阅
    // 即冷信号是disposable 一次性的，用完就释放
    [RACObserve(self.obj, dynamic) subscribeNext:^(id  _Nullable x) {
        NSLog(@"--- %@", x);
    }];

    @weakify(self);
    [self dispatch_after:1 complete:^{
        @strongify(self);
        // 后面KVO则需要重新订阅
        self.obj.dynamic = @"value = 1";
    }];
    
    
    // __weakself 不可用 @weakify(self)
    __weak __typeof(self) weakSelf = self;
    [self dispatch_after:3 complete:^{
        weakSelf.obj.dynamic = @"value = 3";
        
        [RACObserve(weakSelf.obj, dynamic) subscribeNext:^(id  _Nullable x) {
            NSLog(@"重新订阅 --%@", x);
        }];
    }];
        
}

- (void)dispatch_after:(int)time complete:(void(^)(void))complete {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        complete();
    });
}



@end


@implementation AnyObject



@end
