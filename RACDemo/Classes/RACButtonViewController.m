//
//  RACButtonViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACButtonViewController.h"
#import "ReactiveObjC.h"

@interface RACButtonViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *viewObj;

@end

@implementation RACButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // RAC响应按钮
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 响应点击
    }];
    
    
    // RAC响应手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.viewObj addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        // 响应手势
    }];
    
    // RAC通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x.userInfo);
    }];

}



@end
