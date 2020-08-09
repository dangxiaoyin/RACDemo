//
//  RACCombineViewController.h
//  Pods-RACDemo_Example
//
//  Created by dangxy on 2020/8/9.
//

#import <UIKit/UIKit.h>

@class ViewObj;
@interface RACCombineViewController : UIViewController

@end

@interface ViewObj : UIView

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UITextField *keyTextField;
@property (nonatomic, strong) UITextField *subTextField;

@end
