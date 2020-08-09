//
//  RACCombineViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACCombineViewController.h"
#import "ReactiveObjC.h"

@interface RACCombineViewController ()
@property (nonatomic, strong) ViewObj *viewObj;

@end

@implementation RACCombineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self.viewObj.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    
    // combineLatest 把多个信号捆绑成一个信号
    // 最多不要超过5个
    // RACTuple元组 它可以像一个字典，里面有多种类型
    [[RACSignal combineLatest:@[self.viewObj.keyTextField.rac_textSignal, self.viewObj.subTextField.rac_textSignal]] subscribeNext:^(RACTuple * _Nullable x) {
        NSString *key = x.first;
        NSString *sub = x.second;
        
        NSLog(@" -- %@, %@", key, sub);
    }];
    
    
    // reduce合并之后的信号 进行汇总计算使用
    // 2个信号需同时存在
    [[RACSignal combineLatest:@[self.viewObj.keyTextField.rac_textSignal, self.viewObj.subTextField.rac_textSignal] reduce:^id _Nonnull{
        
        return nil;
    }] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@" %@", x);
    }];
    
}


- (ViewObj *)viewObj {
    if (!_viewObj) {
        _viewObj = [[ViewObj alloc] init];
    }
    return _viewObj;
}

@end


@implementation ViewObj


@end
