//
//  RACTextFieldViewController.m
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import "RACTextFieldViewController.h"
#import "ReactiveObjC.h"

@interface RACTextFieldViewController ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *label;

@end

@implementation RACTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self rac_textSignal];
}

- (void)rac_textSignal {
    [self.view addSubview:self.textField];
    [self.view addSubview:self.label];
    
//    @weakify(self);
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        @strongify(self);
        NSLog(@" -- %@", x);
        
        // TODO:
        // self = nil 赋值失败
        self->_label.text = x;
    }];
    
    
    
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
        _textField.backgroundColor = UIColor.grayColor;
        _textField.placeholder = @"this is a textfield";
    }
    return _textField;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.textField.frame), 200, 50)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = UIColor.yellowColor;
        _label.text = @"x";
        _label.textColor = UIColor.redColor;
    }
    return _label;
}


@end
